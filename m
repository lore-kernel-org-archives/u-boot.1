Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FDBC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 052AE407D1;
	Tue, 25 Aug 2026 22:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qR-udiHc51rG; Tue, 25 Aug 2026 22:50:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698231;
	bh=k0Z41NrW7HQS4T7kM6yE8aY42PZCc0Dxzdyjj4MnxCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YWZhtoCAHsgjbyQtZEHWmcjd2t+eW8vZACfkuLTNDRSMzMs+UYmXawTFuSnPe/ZsN
	 j8yGugDCZrpwHWCrb18n/679ojpvqJFkoKbDDZocWv5pAlEVIzhI1ADjrcNXISPQVn
	 VnPRVJc30Qj9ha/fCHhXy0V+C1BNnJj3uLLyaFOpdp4jP9XmysGGtyoQCIdCf5uX9H
	 GITNszM77pCXyo44TSAqyw6gGMPKA7xXzGCUWfN2NvfECblc5GwUYlgcSqhRiOFLbp
	 6Y9biuRux/UtKesjhEc1W7I7QdkBeBqg0vXWV+9Ij2XZsTTIb4hPwgA6aDESNBSLQN
	 Dg53WCuRm7VDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 333E040756;
	Tue, 25 Aug 2026 22:50:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A39E39E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C46F40612
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5vYDFSUQpwNk for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:44:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=QVfZnL90
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp4.osuosl.org (Postfix) with ESMTPS id 9D19B4061D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697852; bh=k0Z41NrW7HQS4T7kM6yE8aY42PZCc0Dxzdyjj4MnxCU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=QVfZnL90hdlp1GOcZC4SNR8sVeSpFnwvRqK6GKTwqB7/+8+SeUrSJL0TqpRW1EsxB4A0YPBotWW9S9qUYBgRpGEBwXXJeKOZpnHY/h9ms9ClzxOeVkSRi2wm0FkXgx/rtlo/WKazz7wp7LznNc/m0M5XZIcIsOeMPEZz4rcDt6YvBB4QfCVnKcjolTqCciLMj9mkiCrjQdoRobbR+Nl8VblpadeHpsl4UH2qWT3rchZPJL6zKxoOPG8rb5FaXE/p2j09nB/sZN5mYb41fqqxFoaucm+mOqZlarT6yColBW/KNtLoN04xAZ2TaQUhXLp9cUZTEcT+001iyfHYqTnG4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697852; bh=UynbhDBRL8gnc0IRzuejzntd7M4k0Rc51BLe7rjDJJ4=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=JT2JkLaNQiYcFETyIs+QnT0S/ehMTq2PyFO12Y0APduhtPef9BjI4ZJWFw+WD6G6k18WIcZf9CqthAirmeoe5nxRisalB3ZOAogWiBWE2kphi6AJGOKPOypwSIVFD0H7va56TTYlGhMJNZuAEBmGTNBdtpYSJrP2/8b2lyHwQPe6l/b0P7pv31/FmjOhkxBTMiWgrXStCz+2OF6QnRC6tPEkCTcKhEKDHdfnqisfLhiM8xq4uyvQM6yeM9zKcZy4543w00VNkMLprVNrDxxdho+VjZmSGwcC7Q8KNCsz825E7x//pDLiSJ4VdCno8z2hGU0vD95CTC4io2Vez0bYiQ==
X-YMail-OSG: eRuD.JgVM1nxA6wQ_WuJFyizARs_6GOHvMeRZs05DHZGky.VPGhls4.WXVAwzcb
 FMM_lpi4pgBo3E4DsggJpO71Q_cTWpTvdpZMqnyNXCw_LX3SyOe6G8AMyYQ2kxzrj05nw6DLtl7I
 1zKrTW1Bv7cuex0ACS9CbRqNkYzjb1WgipnuD1RPbg68_QJO6r_w9EElEVnv3wT0uxLJp_QHQZqF
 aTV7taQPaSPxPz0DYr1t2cS5TKvWD6uScRZX__s_sgSWQtU15Bi1kKT_pvwZ82.M4gD_WLA95R60
 HgVIWs_BmvQRes_ftdGIWR1lUTc0Rvl76u6wQ5umxJJm9vYpnA.WiGZhLQ1va2UjxltM_G7snzaJ
 b8SmCJ7KCTOlIAeLLiNu99VCCinAvQW25hUvUbylpK6Jp6eON0mBkDE9XCdq3tM3yXoW_1rNGXaL
 akg7aEvXT4BdlLDLBxgpJy_Kfvvrwo1rFN0LA9DrLRAFNcChMG2yq771E5judwHvfLTHuDRiEbOB
 YWKenPeiT4ExP1KenuxF1hq76nxwIps4Yv7cLxXVBM9Xxk_TlPN1_UH3JsehQ.qWgoBHoz8mL_2Y
 LQ2arWtsCDAY8x2cvAqUiRdfx9gbPogNOEx.e7Vdi.0HmoW1eB_fTLJPypXSgeFGjF8Q47fBgc_9
 cwhvv3S0ug5gZBZA3JrD4fNWq.cxSFsI5COJysXU.eFmKlJBTWeh9p8w0yBzVQecaF2nN2sQVqGI
 1X2Gz93Y4iaGPfKWWy_suvDhnhDDIJPTo_BAs8_LRhclyDIRaR31rZ9Y07IrxopBJj3SFGi1U43W
 TOV2bvYIFJShqIIbrm.gQwun.Ac.xj9DsvAgcmsvSnkP41EufG1aLeKRxM3K_St4ocNUHHFcjIiA
 VFakn0Q3AcyBCT9g.r0_wh35IVtIUQXpUfEaUEooVhWWqKSDxSYBTFGngWTyhFTYeeg3N0HSR3dV
 e.0CxraNT.fngndB_BShrdt0tMmpWDQvREl_.C_bciHzpAhdbx1L574xgAqb1emjmCMiRxqAGSwy
 .sYNjAdfIisOMmsSehGGs0pEN8CkNaH3zgb1wsY1Qi..b7jjQs2mfOVRK.EbKHhYCm2hjaIRZ4jg
 TSwDKgtjJGRnUixzRs2aUHmsbZeay.y2E1DmCwUJ9ZhzuJvyras3uTOvB8LsAYUJktguDe8fp2Mp
 xOLPztHyQT5_swVvTqPVFSd2wpS6V0grRMmNOaLQtzmPeSWUdvJ7jJfnMdi1B3VIk__V6XOhYRl2
 KlvNbnRM.90Aifzn6OqYSLeU3pWcx3mvO7AtlJh2OMSELeTVKrup8TyQrk2o5e9Ue1Xzuspc2xbI
 VocjmUjaagdm49UYeR_1z_kr74cYlo.AFg7jwGx2gYE9eSlubZQ234cPnWb8XbUWWe9nFKoayswH
 8Xa_VgRay6TaqCRz9iRaHCB00EniPxz2Z7LI0JQlODKGLoUOaPBFpMN8ZMG..a2Gpkda7y0YJ_8m
 1YisrEDQcX1ivfryPELxAeB1sZrC33REo7e4r4cPlioVJlX6SR8Na_5vJB1CEYFFgYX.Q6.yrCs1
 VUkwlx9lHGWSwlN41k_6cZtp4x8P6Bs0w.P0FH5gtbPwcVOXUwcuZJbJnBRvSfYpt84HCMY2bb7h
 BVKyPInBbthudpzsmDUSmxXaM52fnV5EvVI3jeMPQnjemwzn_IDFtX3ngHXjSUkPLbfsakYRUWrK
 KmRXzEU0uv9Cb019Qx5yJLBoV3VEh9MfxuO0aPySu2pjQSoL8QNsW3UFoh35RaO.fLXmab5QXkLS
 m8Y9LwGtWdzlEq9J6Rn41YPJR9AUztxTUxA6eNwCgd37kgQPHmMCz6Hl_ZnEgKAnxQwNC.dD4.zW
 KMbjwFeRJJRDPpJ4iY99TBjJso7fXhG6NRmbU5HQI8_Qntpw1e0YGj_uAoZ_sL8adUd3O7s3HHUa
 hRrlbA.UsjhXkYcTkLcCp4Kfu4orKVL2taTSIM87hzqgQASkB8hkm_us35JdjwzBSqt.iso_KlDE
 cGVBbk54QxfAfnm9XmwYyj8XxGPZKt4vHoNiuyvyajNWL6Ch_RXqiW0xLMum2cDyzK1s0uRLet8C
 SuTeS.Q--
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: a97e5ea3-a3fa-4368-84b1-94ea28d66389
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP;
 Tue, 25 Aug 2026 22:44:12 +0000
Received: from dip125.lsn.sg3.yahoo.com ([106.10.223.134])
 by hello (SMTP) with SMTP ID 692ceff9cbf31ebf3ce1df27c5387b11;
 Tue, 25 Aug 2026 22:44:11 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v1 08/12] boot: image: add weak hooks for the decompression
 buffer and flush
Date: Wed, 26 Aug 2026 04:12:03 +0530
Message-ID: <20260825224330.713151-9-maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825224330.713151-1-maskachoska@yahoo.com>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 22:49:58 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add two weak hooks around the bootm image decompression:
image_get_decomp_buf() lets a platform redirect the decompression
destination (e.g. to an uncached window), and image_decomp_flush() lets
it flush the caches over the decompressed image. Both default to no-ops,
so existing platforms are unaffected. The EN75xx uses them to keep the
kernel coherent on its cache-coherent CM.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 boot/image.c    | 34 +++++++++++++++++++++++++++-------
 include/image.h |  5 +++++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/boot/image.c b/boot/image.c
index 185d52ba..680a78da 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -442,15 +442,31 @@ int image_decomp_type(const unsigned char *buf, ulong len)
 	return cmagic->comp_id;
 }
 
+#if !defined(USE_HOSTCC)
+void *__weak image_get_decomp_buf(void *load_buf)
+{
+	return load_buf;
+}
+
+void __weak image_decomp_flush(ulong load, ulong image_len)
+{
+}
+#endif
+
 int image_decomp(int comp, ulong load, ulong image_start, int type,
 		 void *load_buf, void *image_buf, ulong image_len,
 		 uint unc_len, ulong *load_end)
 {
 	int ret = -ENOSYS;
+	void *dst = load_buf;
 
 	*load_end = load;
 	print_decomp_msg(comp, type, load == image_start, load);
 
+#if !defined(USE_HOSTCC)
+	dst = image_get_decomp_buf(load_buf);
+#endif
+
 	/*
 	 * Load the image to the right place, decompressing if needed. After
 	 * this, image_len will be set to the number of uncompressed bytes
@@ -462,13 +478,13 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
 		if (load == image_start)
 			break;
 		if (image_len <= unc_len)
-			memmove_wd(load_buf, image_buf, image_len, CHUNKSZ);
+			memmove_wd(dst, image_buf, image_len, CHUNKSZ);
 		else
 			ret = -ENOSPC;
 		break;
 	case IH_COMP_GZIP:
 		if (!tools_build() && CONFIG_IS_ENABLED(GZIP))
-			ret = gunzip(load_buf, unc_len, image_buf, &image_len);
+			ret = gunzip(dst, unc_len, image_buf, &image_len);
 		break;
 	case IH_COMP_BZIP2:
 		if (!tools_build() && CONFIG_IS_ENABLED(BZIP2)) {
@@ -479,7 +495,7 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
 			 * use slower decompression algorithm which requires
 			 * at most 2300 KB of memory.
 			 */
-			ret = BZ2_bzBuffToBuffDecompress(load_buf, &size,
+			ret = BZ2_bzBuffToBuffDecompress(dst, &size,
 				image_buf, image_len, CONSERVE_MEMORY, 0);
 			image_len = size;
 		}
@@ -488,7 +504,7 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
 		if (!tools_build() && CONFIG_IS_ENABLED(LZMA)) {
 			SizeT lzma_len = unc_len;
 
-			ret = lzmaBuffToBuffDecompress(load_buf, &lzma_len,
+			ret = lzmaBuffToBuffDecompress(dst, &lzma_len,
 						       image_buf, image_len);
 			image_len = lzma_len;
 		}
@@ -497,7 +513,7 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
 		if (!tools_build() && CONFIG_IS_ENABLED(LZO)) {
 			size_t size = unc_len;
 
-			ret = lzop_decompress(image_buf, image_len, load_buf, &size);
+			ret = lzop_decompress(image_buf, image_len, dst, &size);
 			image_len = size;
 		}
 		break;
@@ -505,7 +521,7 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
 		if (!tools_build() && CONFIG_IS_ENABLED(LZ4)) {
 			size_t size = unc_len;
 
-			ret = ulz4fn(image_buf, image_len, load_buf, &size);
+			ret = ulz4fn(image_buf, image_len, dst, &size);
 			image_len = size;
 		}
 		break;
@@ -514,7 +530,7 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
 			struct abuf in, out;
 
 			abuf_init_set(&in, image_buf, image_len);
-			abuf_init_set(&out, load_buf, unc_len);
+			abuf_init_set(&out, dst, unc_len);
 			ret = zstd_decompress(&in, &out);
 			if (ret >= 0) {
 				image_len = ret;
@@ -532,6 +548,10 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
 	if (ret)
 		return ret;
 
+#if !defined(USE_HOSTCC)
+	image_decomp_flush(load, image_len);
+#endif
+
 	return 0;
 }
 
diff --git a/include/image.h b/include/image.h
index 34efac60..b2a6c536 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1014,6 +1014,11 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
 		 void *load_buf, void *image_buf, ulong image_len,
 		 uint unc_len, ulong *load_end);
 
+#ifndef USE_HOSTCC
+void *image_get_decomp_buf(void *load_buf);
+void image_decomp_flush(ulong load, ulong image_len);
+#endif
+
 /**
  * Set up properties in the FDT
  *
-- 
2.53.0


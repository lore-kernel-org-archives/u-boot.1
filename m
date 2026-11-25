Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A4606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v9jT1mCW;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pltXoKJ5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38A9A608BB;
	Wed, 25 Nov 2026 12:43:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T1JDBLfQKMS9; Wed, 25 Nov 2026 12:43:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 44D2D608BD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795610597;
	b=oxW/YCrqjYTBL1fnmCmT8JH7Fx/moYXPLAQzJpvKSYp9nYyabr4lxWFwVkTvDboQhF2l
	 AlRBeoGq8qKFpL8EqzFuqfSEU91TU5wXqoiLaCaBDYwLDFnD7+dnHY4xog85NXBMLhWYL
	 TT+JlDt2KzpsdMsQo2F9fSCsOZecMlAR7G+t+0cDTAGv/+R1kr4ZfxvdUPX2sNiuBdBPX
	 MB9suBSsVSfFCdGzX43HZFN1hms7Dv3r81XqkjVxQAUbzEeWUEVtRwdF12x0ckTGrFf6E
	 l4J+w+VzHJdWNlZpq+nggoYo98B3L6Z1ga8hyIouQ7AvNmifsx/o6opY+WJ9u6foHpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795610597;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=M4iRTb2ljph8MH2xGvTEhdtJUXr5JFD+msjkNNSohoE=;
	b=oyqab7FL11/bvQQpXh50rCrKcA6xSdIQjhFoO27h532escqzqnK6ij+U1vFSCxqu4ExX
	 ukitsOFmwjpt54mw+FxYvRq+MBhGlXbSCUQxgQtim9TNbUDQd0X7M3K8ne6or/9+THYZq
	 MclBn2sB+MAwuIjKVpwgA2tpEI5OZS5Rk6iqYrp6xfVdsWrtIUowS0oIiEsNsRGOmb96i
	 TarDuNXUID2KU+iIb4rRND2z5+6Rp6N8ppTuBT+imF9TImjEv8RPrRduDIrB95gmQ+Vj+
	 53uwNRbBMFBUjml5UAzAQdbY8cYrR3dMH16SwXoom1qWyM48ExaA1a4g23V5RxuNl0A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795610597;
	bh=M4iRTb2ljph8MH2xGvTEhdtJUXr5JFD+msjkNNSohoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v9jT1mCWlT/6DYo/nyCXY9WEdM/xJQXN+YwKwwp/JG14cEpReIbhseYn4khTveJE1
	 CaeZr5x/VjEXEwwpvnhv/LGAWXE9aM5iNoq4CaYk48rRbTOwI/CCfGrDh/zYHZJQJu
	 WHnUT2mA+Og+i7jbif2+XS7MzxTUg07rntjXBmxKWRYw0LQKYIOXlIGUug7mvNGjCd
	 3aS4oWV2bxG4oaU2cSHdws09wVFkmznwAclOpCPU/sM0uhGPWLzkqyqJ/8xnumVu3n
	 OMHDYrmNAhDtW0TOksWLjqaxW4KDmSGzpSm9fSYWqU/TYtZCArUYTjpbl37YIQzhld
	 L3h47SC7PQOGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44D2D608BD;
	Wed, 25 Nov 2026 12:43:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 32A5732D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30283401FE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g8O6mbnme9FT for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 12:43:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4AAE440116
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=pltXoKJ5
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AAE440116
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:08 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so26984965e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795610587; x=1796215387;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M4iRTb2ljph8MH2xGvTEhdtJUXr5JFD+msjkNNSohoE=;
 b=pltXoKJ53JHoP443ac9kRK7z0cjoivXbJhn61fMSVyO3t4iVCg3HtW2WRXzVN4iIgg
 ZH6PGR9xv6Y0H9Bhqw60uH+2Ng6yaZsQuBDKvymn850KE6GovMAIQ/Jw7WSSU1pkbomV
 TzuUW23SzUrl+gTaY4EdYyDU8qzWxZYzBqQnoDOppX2PdBW09lae5s2z8RN4NCv7OCGL
 GQkJkzEktsmwyRJEVCcS0dTJbvWAtiXr0moMmNSARJqXKidVCNCociECQ/JB7fYlB340
 lwmrzzoC0c22wmvVx2c0bVSHGAVvHukljppIFMQWCnxLr+BOr6bdJTjupfT4yV1eBbk3
 fktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795610587; x=1796215387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M4iRTb2ljph8MH2xGvTEhdtJUXr5JFD+msjkNNSohoE=;
 b=rth77TlqlYXbdpDd4qNSBdNfHvxbG6iha9C8I2eG5EPWepJJ1kJRfY83lgMdD4AWRN
 IvfAiCduQxZKBvdZA8ScXk/QrHLxxWWrdmqHnW/ivX5FFJAI0SBZwt56lzRnQTvRpicq
 vBsntoZKcnLc4/KkarUNLVtG4w6OO+MGaDxV2Zzs6KIZzjQd/ZjANdG2nMDFczeAg3N3
 O2zFwe4/ODi+q4/BdRs4rNEuhalyDM4AjrsP8JJOpuQKgwQWEY6buGBE0ZNS2NKSsWjj
 yPyxfGJYol9+iclft/iSwr5RLkEfyGk11Z0ST6l5LPUVxOQJNW2n+x82F5o3tvq6+R0X
 Kmcw==
X-Gm-Message-State: APuU4Z8s+EIsXmFz3E37VuQfnnbJAa+5WsDY8KSs4NKv/2Xb5x0KYRmq
 7AfZ92f9vUoJXH/Abj/idZtj60WjtFPRP94lA/gkE9cAB74koHXIuhXfKDMlsZ95
X-Gm-Gg: AZFdTZcvFbt4+tTWEVXWbWhApqahmVUKCzTcMJ17+b+O+1FQej8STgjghqkLHZ7XzhJ
 rDqm9id2HVXUwl4aj1EXmjIHT9EPC5/+5u6aAirdygRdEBd/8w97IwNC5LP7XLIrtyMuYELHx3e
 DW+bmMmQIES0Du+zNwwjgdPibnhVrDBIegHg78SpIe4bAzqyH4Qtw3o90w9y5J6TzOkaxA9jnlx
 FGRyX7BNaUEMwe1IR4JReZhD5Jlra3PL4H4MS9pmCg9hG6szTimEEYfdLcvq/GFuHhaM/8KlYIr
 YzKbWfbHDgmhinKoI2DH0S04fz1NIoUXHE2IKBb4lZG1/870D1IH2NxD/AmD+wgn68q5GFDh1Qg
 wnciwX4KRP9aHmgbsg56fsx92c08hzQwyVHeR5LDCqCa6HCNpeyaXe8+QKIMHLQum13U9V/wa7O
 IC4KvGr9jqzoSiwT7hb395HBS0NVTnf+932Bk2G3JvaNQC7om+jvxZL7ngEzNFC+rQOrz1baPg6
 SMXWXvEQoT2yJiDPj7uw9rxk3S8dXKOybvIvDPqmQDN0VZy8YuenbuCPyoe3ztiIhtJ5pxllEDU
 lokYrn0g500sbAixk3t7hsyDRYy0zYURvoP174wu13kHPInFlevCVL5iJf6K0LfA3DgUQf1prDy
 rlCD8TO6RVshPV/aSIevVIdrRdMCrcm58StYmYzj2VleeHVboZnIEaTfJS1DDoI0cAhtmP0DPOS
 saBCHzK6lMWLw+YhXIAdejyfjo8gPUL0gv2W9eAff8ndGr1RkfXYnT0w==
X-Received: by 2002:a05:600c:a05:b0:4bb:5e6b:49e with SMTP id
 5b1f17b1804b1-4bb88807c0fmr358740775e9.6.1795610586809; 
 Wed, 25 Nov 2026 04:43:06 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-7575-e1e3-dbaf-96fb.ipv6.o2.cz.
 [2a00:1028:8388:a84e:7575:e1e3:dbaf:96fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm536486045e9.2.2026.11.25.04.43.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 04:43:06 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>
Subject: [PATCH 4/6] powerpc: mpc8xxx: Avoid a 64-bit division in get_win_cnt()
Date: Wed, 25 Nov 2026 13:42:57 +0100
Message-ID: <20261125124259.95636-5-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
References: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GCC turns the u64 division in get_win_cnt() into a call to __udivdi3(),
which U-Boot's private libgcc does not provide.

Compare size with the product of win_cnt and PAMU_PAGE_SIZE instead.
For a non-zero win_cnt, size / win_cnt < PAMU_PAGE_SIZE holds exactly
when size < win_cnt * PAMU_PAGE_SIZE, and the product is at most
128 * 4096.

Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/powerpc/cpu/mpc8xxx/fsl_pamu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
index 638c3a6fee5..b6f8552d7d8 100644
--- a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
+++ b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
@@ -364,7 +364,7 @@ static uint32_t get_win_cnt(uint64_t size)
 {
 	uint32_t win_cnt = DEFAULT_NUM_SUBWINDOWS;
 
-	while (win_cnt && (size/win_cnt) < PAMU_PAGE_SIZE)
+	while (win_cnt && size < (uint64_t)win_cnt * PAMU_PAGE_SIZE)
 		win_cnt >>= 1;
 
 	return win_cnt;
-- 
2.54.0 (Apple Git-157)


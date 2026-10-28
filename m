Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF2606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FQabHfMG;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OEGmYAVw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 312C081238;
	Wed, 28 Oct 2026 14:47:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1WplV83XhCW3; Wed, 28 Oct 2026 14:47:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5BC881107
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198820;
	b=GM/+mDHO1OnbVCodNah+hJxAHmm1Y/BxNMT2lpuoMliNy9oHaG+Oi2NvbL/W74AGxOR9
	 /UuaSuVT14D91F2I5x828RBR1fD86/FYwgWKu+EzTGTFr1z+3je35gz54WoR5iDbN3fJh
	 EERfBnXpOkVi98YtNu3nOhz+XaX2Qc6Uxid8TC+l5pUW2itvQi34F7saC4TN4YqYxcRKT
	 wPUCLto2u8gGk8ZT41BRHejVOMNT+xloiodjUusfYPNh0jT8v3ZfaKsBtK75Gko0uEU3K
	 SUOqtDJYOQ9Wo2DeegjWBR6kQEzty6s6NAmG2Ke2kLwhZFUSzMv7zn788zEjI3Sz2Nw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ORfz1uD04LxdPEu+rbyxJQsTRgr5qkxZwyo7NsZIm0E=;
	b=E6HyTSyc5CnnIFplzv578rNg9gpCA+yAZQ5+wxhyobuXu5EWuVsK3mFORgBg8xee0io6
	 AFGE0ENSdAeETv7g2nCu8gwUxv3E9wZmVn9xfzUtUdysC2383neZNm3IbVFq2nj2u2oZi
	 zZ8wfv4tnzcIW9EXGnX0NaosAPIEmU5XFE7ndSdbEY64cW9BVuyVkZTD8d74cNIi5OXJB
	 S/17IU7KmUuDtCuTVyOdORfa8BmHIJwaeDv9egLpKKubw/ewqY0zCHH9JFcelJG1SkRrj
	 ihB9f37aKWxeYkTAbw0iDoE42Ib84wgkxaDr6agGZUYkAOlv1R0sEhJoUevUQOKIZxA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198820;
	bh=ORfz1uD04LxdPEu+rbyxJQsTRgr5qkxZwyo7NsZIm0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FQabHfMGw2f0ZF6x9mub7X7VGMq+aoQ9nNq0caGqyn16vAJ7SzS2LIvn6/5vpGaRU
	 Xygo1/ZuzQ0xUyeXuM0AxpOdc57DyFsa6oHln0+x+ZwlYUO5kGLWj+dqjPZr+RMroy
	 HtQc9vd+Wlw/npqkpq35YOr812aSC3CSnhntUg+P9ugWTSVraJTbHj1KoCDn7BUvPe
	 MKNZRAFajszMsGZq+vENErz7yP7PUMa9wKAWu+Ziue6S4ne2jSr7a0E7rfdCE5ClZ5
	 saY04CNDpc92cafkCFtvvhgA4ZNjTn8eBo6ftoEpZENyCT8r/hktmYm6ATaQq2FfKF
	 jWIewyb5pwVBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5BC881107;
	Wed, 28 Oct 2026 14:46:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D6C2235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F4486060A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6YPG0eQQ7W2Z for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:12:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6CF0C605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196752;
 b=lpklWSAMQbEdXzvIjuQAY6XDBoje3mvgfdGJ/V0TVwsYxTTuzbSjKabq2bdKRLFd7fu1
 u/29QBKfHgpbqQeVIVooIfAszLj3bkN8Zo5Fu9Fq77i31h2PNXJEIHwm7mS5rxKp1ZKer
 6r5Zc8couDnFCazq5lv1m2DlyKmGKvDMZZXT6k4JrrJTm1ALyKPW3JjutoS/UDKMax9uO
 SF6u/U3tAS+wTapTm2yAvSwYdmIpUKnPdDL9F0neUwl4TJ0d+UJ7Pw9mroy606GVC27L3
 3O7plZQIS7lvbRJe+3xXCykkhj17V9EpPp2whrqoV5VEczSQeYghYfryOBy+mYjSVUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196752;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ORfz1uD04LxdPEu+rbyxJQsTRgr5qkxZwyo7NsZIm0E=;
 b=G8g96Wx95bjDppQdwWpjYzbhCKamRt2CJQtvIhsELbr7/SCoOOwvbCXp0HxUCTsXmFLa
 Prpy8ycDLwU4Sd/t/XaygAzv1ud/j+WULNuoXGY4sNWE8Mmk7k+/spasa42dvx8VKO/aQ
 7k8QBs49vOAcgrCgXAcs3aQohlFM5RFv8SFlqpUH6dvYCJwUzwCPxG+qqu6Gavacya0Ae
 nASRFop4L0AMsMD2X41wFo3fMrjhr1EfU4j5IGYKPpb2K5gd5XAknYlGrbPqqMx0iwefY
 maUlq3tc9YuLFuZm3hM/t56pqEY7jGMFDDkb4VN0eH5JfHTvrQekSQG6QHgaT/rW3qw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OEGmYAVw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=OEGmYAVw
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CF0C605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:32 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c40aa03a96fso11205066b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196750; x=1793801550;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ORfz1uD04LxdPEu+rbyxJQsTRgr5qkxZwyo7NsZIm0E=;
 b=OEGmYAVwKXoR2dl6gLrpViGQlFBnrsVjLehnWCmrleangyC+1Ql+tEeuv3x1u5Z9jV
 w8vrvbWDomiHCBV1ao8ZS3n1hb3ApTn0sqcilXe6k/AwMMlNwceKiy4B4oBDmz+SJzM+
 XY+fkpwDVyMGSQaqEgZO1Vs1uPjwqOeHxSxIBDvgS2a0V0kd0lRSNqxMI0ZSuFjSdI7t
 R7qerg9f/9X0kxL7P9FVcD/PkV55O6vOY75x9iQFRqw4YzANzm5OFY1YD7OC6lT51Ikg
 TPXaskPsEexuiPdWuMZrud7rxzH/15WsnFODbSU4Jj5LbBXsLXC3YUw3xinMTfstImVf
 gCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196750; x=1793801550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ORfz1uD04LxdPEu+rbyxJQsTRgr5qkxZwyo7NsZIm0E=;
 b=temmwcVvHvr5XJpqpWSRigQygDtdWUj81bTL7wTdSc43vahBTDZAaf1j/FvZ1enN9p
 /UuCh7yfQnv3Yq6gB9ekDVEIkoj249m3EDnWUEIv9c/DpaZO/9Bkp0rGuAjAdZi8nn8B
 WtlgddV/MN/50p70hUAWs5s9fcmJxcyP98IOBVaRCJu5ScjrCvgT+k8V/21czfqOQyAT
 Lg0CRcwz2mBuUujtfpwhEN3hnf2lEvTEiiWuVjLLJulzskpp1eKW8F1dJmALo3E+4HS5
 B4Yf/skRRRLaT2bhgYG7csndOWEFmXJozD+H5ZpSI12OzETwMdrIeHYC1OXGf0CtxxGG
 YyAg==
X-Gm-Message-State: AFq9FYKtBBikYEkTCcNysYd06o29k7yxNB8Yx0eF6i5GgCTxsoZqikb6
 ylTxhxaNFKa/+e7JxBr5WF1JMuV2qez0LYPMET1DGbWovoRkeQHRPx1zNHUXatxUorupwrxsDFA
 coe32
X-Gm-Gg: AYBFou0eeGqRT7DuuQcmAQwapLQbLvgycYcU0dd5crK8esGXXNk3Zpy2GWYSrW8NrYJ
 6RsOYvksasYVRa8Jz721Oy7XwoSpPyy9FhpiYtwIRyV4ld6U9R4fU+/2mJbmXY182EDdbsO0akX
 Yp7999CkuQuIhlbFRh8op2CQ6iEgVNXgAKVn8wSBSVVNa0cRRYZ5gaZv+O+lQNNGX/iAX7ixu39
 A3owKsCEuW4mlD1GKvBmN3PatdRLpKFaefcxdktljHBQyTJwoa8JbGKT/6DfI8Bq9JvuS4F69F9
 AL9ROSTX+uHYY2Jev+Jw98YbJU3AQ/3xVD+rHmfDGGGvhKY4RyWJLbxZLQlOtFaG51fnxvn8HvG
 8+cjQ5lULFfBHPx4UuGYVWFSqIQ61Z6zMSXTEan1DzqdUORDwkaLFP+XYjxpQ+M7XW2xOuRA5ei
 cyo6UrSk2RRQNGw7jNFhDb7gaoKBc2pPsRVvbz1lYenq2g7ajHdUk8bu1ci/I0FzqMpAFVkFnXL
 pIO+dBfNQ3gi54RNsUKb7iuPNi8iAyYoq9igWqyZvG1Ork6sWsTSCdn2MKHuCeJyGdq5H6U+698
 BjnEOwKV6nb1m3QvqSN8IefRigft1zYdHz3Lu35htz/ndBjPf9OVVWfR6rJafjhp6xUt6wqYuNT
 NFDjjAlX9hQ==
X-Received: by 2002:a17:906:d932:b0:c43:f1ab:167c with SMTP id
 a640c23a62f3a-c49bdd9ab19mr228813566b.1.1793196750226; 
 Wed, 28 Oct 2026 07:12:30 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4ea351sm606060666b.28.2026.10.28.07.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:12:29 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 36/63] usb: dwc3: import from kernel v5.11
Date: Wed, 28 Oct 2026 15:09:02 +0100
Message-ID: <20261028140930.3025368-37-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v5.10 to v5.11.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v5.10..v5.11
Commits imported:
0e5a3c8284a3 usb: dwc3: fix clock issue during resume in OTG mode
a5c7682aaaa1 usb: dwc3: gadget: Clear wait flag on dequeue
a1383b3537a7 usb: dwc3: gadget: Restart DWC3 gadget when enabling pullup
ce722da66d3e usb: dwc3: ulpi: Use VStsDone to detect PHY regs access completion

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  2 +-
 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/gadget.c | 16 +++++-----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 841daec70b6e..3101f0dcf6ae 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1758,7 +1758,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (PMSG_IS_AUTO(msg))
 			break;
 
-		ret = dwc3_core_init(dwc);
+		ret = dwc3_core_init_for_resume(dwc);
 		if (ret)
 			return ret;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 2f95f08ca511..1b241f937d8f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -285,6 +285,7 @@
 
 /* Global USB2 PHY Vendor Control Register */
 #define DWC3_GUSB2PHYACC_NEWREGREQ	BIT(25)
+#define DWC3_GUSB2PHYACC_DONE		BIT(24)
 #define DWC3_GUSB2PHYACC_BUSY		BIT(23)
 #define DWC3_GUSB2PHYACC_WRITE		BIT(22)
 #define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 78cb4db8a6e4..ee44321fee38 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1763,6 +1763,8 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			list_for_each_entry_safe(r, t, &dep->started_list, list)
 				dwc3_gadget_move_cancelled_request(r);
 
+			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
+
 			goto out;
 		}
 	}
@@ -2083,6 +2085,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 
 static void dwc3_gadget_disable_irq(struct dwc3 *dwc);
 static void __dwc3_gadget_stop(struct dwc3 *dwc);
+static int __dwc3_gadget_start(struct dwc3 *dwc);
 
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 {
@@ -2145,6 +2148,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
 						dwc->ev_buf->length;
 		}
+	} else {
+		__dwc3_gadget_start(dwc);
 	}
 
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
@@ -2319,10 +2324,6 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	}
 
 	dwc->gadget_driver	= driver;
-
-	if (pm_runtime_active(dwc->dev))
-		__dwc3_gadget_start(dwc);
-
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
@@ -2348,13 +2349,6 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-
-	if (pm_runtime_suspended(dwc->dev))
-		goto out;
-
-	__dwc3_gadget_stop(dwc);
-
-out:
 	dwc->gadget_driver	= NULL;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-- 
2.53.0


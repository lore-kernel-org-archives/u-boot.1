Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9536ACA5FAB
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C4B980BD6;
	Mon, 28 Sep 2026 22:44:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HGS2wxIJlzw0; Mon, 28 Sep 2026 22:43:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B259280AE3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635439;
	b=secID8gHEsjJ9m7KLonubd4utDLFQIjNb0pXB0/G7EEI8fldRJa3fHdLgn86202gmwmu
	 M1SibrWJ0XhTqEwUluEtVme7psVyAwRfiIXWwNvHKuEzMaY+IGgzbTJl6Ij8Qc3Fds+JR
	 PkF4U9sxHrYgFIk0dZyl7rWl+NCcCJW7zSRSsvaWn9KOpIyXbc8LXZwo73yfK9PXppXkr
	 rwvqLbFudBhrAa2UfIiFVqjcJcuqrrsfBRgKfyJ4xjx3z377hwaWn8GUBrb0dnU13rALb
	 n3zWk3L1lOYsUWy8TXJcf4v3wBJ/ticagcxshdzkR4CRKA14cZjvVXfRVRKmsftQYZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790635439;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+1AZPJB+hfJDgtREJFrSX1x5MSWVcrjlsVAoObUWzEs=;
	b=getaaauZJpRIPy5l8PuY8yUnYptn0iUrExt7bp4VkG58LxUKEpMx2M/YfelwalVeNihR
	 XRE7FZV1iuHV0v0KZGGDKM6sDeoXdlngM0gfG9BX73qFrHwb9CbWVU+SfP8DRSYOBqfvK
	 FYQgKqXEFezFfKN0RNqadr1voScau6G+fYhbSmyXl7NpRIhW1zBulH9Ku2F7Wb77wB/w5
	 7h/kxYLkV2wGNnJTGs0AX2giq+J18Wu3Q62yUTuvcBhh07SIlXIBz9x7tvK0WXz6iNMTW
	 u3jIW3+CrjqiiisU8hxF6gJ86zgaatSZALS/YUpxD1Iv1EZjFwPLkSyVMcIfBd+GShA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tAkh9QM3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790635439;
	bh=+1AZPJB+hfJDgtREJFrSX1x5MSWVcrjlsVAoObUWzEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CmIsKTEXIN5k4K6hUZ0GJUSlOzryGNnm3OxPwgIHBn5Mo6/A+szicrbfbMlRblNWD
	 zyS++SOcxSRUiiP7Ibtc8P6/th5NsIRD5SOxashhhNtDyS4k8m28B0Vx01Xuf30c+E
	 B7CXXmO2SPkEmrVAycO2yt+Tf4hk86a6j4MbN0VEVCmEXtm2iVhfbWqWMKIxu5XdRK
	 nnaXwHBB7sp47X0OBhMSTMFhDjnAKfdqfiARAe9QU48QH00hI2nJqvrtBx/e2vNzbQ
	 zumAZB0/bpqhVmkBo9BX5ixVElQGBWHza+hB5eBvz1hGbIMryXRrbJgT2TU2BZ+Q/v
	 iQpK0XWt7J8SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B259280AE3;
	Mon, 28 Sep 2026 22:43:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 52D96335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 43A1080BCD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-DwJSZFlafu for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:43:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5AC3D80BB7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:36::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790635437;
 b=G9LG34EhD+kQMk9k+9pZTZNLCioiYi8zjYQiOR4njqFM3TMlbLX7i/VBBvxUosw9gQYQ
 6ug0qqamihaagcXXo0IejhfcSzzSO26Z6yS9eJhXdRMPkicf1GJL3txAyx3B7JhSn3Vnh
 6hOUBHowGgMLUQvvRhPWOVr1dAVv8m4T6URlbWdEtTXvbU1c0yIfiFO4+YVFsCmREs48t
 1j8UmQLU98R0F3zGKCq50tXNTc0jCFJxnAuDS/xYDSOg/3Qpqu1eA7RjPZEBSTgVAz1z4
 90fAuHNGyZqnt3icyWkn4nXgsbrz6G5SF1tMuP5SSj9I/8HaBRLQmpssNFmCRKAgHug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790635437;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=+1AZPJB+hfJDgtREJFrSX1x5MSWVcrjlsVAoObUWzEs=;
 b=C+M9lDw/q7xN7GWf68O7uyl7ouDRVSaqJljad6Tn/wo/NlO8VZDbz44KTTkJSFR6PR5V
 /lg6JDD/EhS/k2yk6SdUOLHkg2GLWeXK45tZKcuSGBplKXZ4t2cSjxxfhpqgJ/LG9QfV4
 z8g3TkNTbeey2rF7k88QZ0njcM8KaFhmqMvIWu0/lbOEUXstizhwnQ//8ECjbFmo4O4nl
 t4XPvoPtsrEyhRwcqMhh44hyn2xP3FT/APLksKDUG8HPnQff0G+U9deZNTMPrPKlVwyO0
 wpT54pBLw3fabo2PAim/CxFH29/zgo2AKePHn2Wugs6iBQTmT7ZkOFUk9zcbR/iFXOw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=tAkh9QM3; 
 arc=none smtp.remote-ip="2a00:1450:4864:36::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::11; helo=mail-lf2-x11.google.com;
 envelope-from=sochnev.v.74@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=tAkh9QM3
Received: from mail-lf2-x11.google.com (mail-lf2-x11.google.com
 [IPv6:2a00:1450:4864:36::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5AC3D80BB7
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:55 +0000 (UTC)
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b8e6ec4dc0so3403526e87.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790635434; x=1791240234;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+1AZPJB+hfJDgtREJFrSX1x5MSWVcrjlsVAoObUWzEs=;
 b=tAkh9QM3NjUtOfVGHfpsIoW+X7pN/NGW9eIK+h7l5VdcUkVmCzI+LeVCnt823ohPjd
 v3xTahmcx0eYfqkJa059IziptRrx+B3Su9AHKm/3Ngt3xuABx1yazgvNgwyC96Je9nR8
 Pp+JYFvHydon2tDYZvmEev7+/pXYXnVFxXX355uiqFISBkPbycKyD6d5D/SBx8zu1g0z
 ed8mwqJtPkgkULIRzYW7KIADSYlJPfA5JMKepVhw248hhqIc4QaZiu0iio6df7A0rktH
 s54BBbl9bdSWJoAbZELGeulYJQXVtgE7aAV2o2xaSme33J0/UCSDPNxf4SA+IoCNblSV
 6w8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790635434; x=1791240234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+1AZPJB+hfJDgtREJFrSX1x5MSWVcrjlsVAoObUWzEs=;
 b=n2lXwna23iPI7oQPWhepS+c/bi8kXeJQkE5GsY4N13vQ4VhuzG6ljVJAB8ljAkIHhK
 l6acCG9dlPDa8RWlm/WWZoewWttGk4eTIH1TAWWxKom/C11Nm9WTlLpEtF0z0+EInqg4
 xWsNhETTlLrUGuy09EbxlzJwMmoZlvC+V0LDCg5k6ojfsZjA+St8SGtmr+yqtlhohjDL
 HYi/eCz5cIWlHKhgk4NCQjT3tIPQ8szgiyp0iokPILmNtdivfz+mZ6e5tzFoKgPHZnIZ
 ITqfDMH4mJrDYkk3cWPiLSEOHdLBEL6aH7oRLa00gI0fJ+aeUBTA4pS6cWWuXstkUIVj
 q4GQ==
X-Gm-Message-State: AFq9FYLgfCAklbeEkxGPTu6CaJLhOpbQvVduhNHjlruXoG3YkgRK8dbW
 ZEwZtMAym0b+9tBOXwxz3kI3yFsWcx28X6VNvJEi1squ/T9B/UzjE6FYGe3SPMo=
X-Gm-Gg: AYBFou3k+zHMK7TJw5epAbPK12inLjiyrBCYhgytm+j47Usdbac5V+DADDA+16NQyJS
 cl4AtVhOMsBvG9e2ElcC/qrPOSUBwu2GZsz0a3eOC8qZlr+sVU4iRGahRJ5WeqxA/p2Ss0ZXzKI
 8r16fTHpF/rMbqc8/gWGnr9eCvqcg5/WthGZhllRJrMQnly7zInKNxDvPv7unzh0aptitmooO4W
 91zZdRnP92Dct+hj84/vx4PPkDm8Iy6TKLPo3t2nDgWnolWQdnt+L2qFCqHLN4w3u7oYinXcJkN
 8LLcVBGON1B5d1L8nnqN5SUBSqMU3rzxs820rIt9J1qgg5u+jrjJEYS+MlwpVR6KxSlPSn3bl5V
 uWEKtKYPre3V/Zgb061qFhe2pyjwMSfSJ+BCq2iynczswanPLNKx5lWaaJCv9apk4TZyRWyLE2W
 tyW8ytcoEd4l07jcABZg+PlhHHAP2CFzdS0DqGGgAsEtJH4McdIHpqdsEKOrNcwA==
X-Received: by 2002:a05:6512:6885:10b0:5b8:f960:1bb9 with SMTP id
 2adb3069b0e04-5b8f960200emr981568e87.62.1790635433700; 
 Mon, 28 Sep 2026 15:43:53 -0700 (PDT)
Received: from fedora ([46.8.219.5]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b9debb0eccsm902212e87.43.2026.09.28.15.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 15:43:53 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: u-boot@lists.u-boot-project.org,
	trini@konsulko.com
Cc: ansuelsmth@gmail.com, mikhail.kshevetskiy@iopsys.eu, sughosh.ganu@arm.com,
 xypron.glpk@gmx.de, Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH RESEND 2/2] configs: an7581_evb: enable the Airoha TRNG
Date: Tue, 29 Sep 2026 01:43:38 +0300
Message-ID: <20260928224338.505923-2-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928224338.505923-1-sochnev.v.74@gmail.com>
References: <20260928224338.505923-1-sochnev.v.74@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The en7581 dtsi from dts/upstream already has the TRNG node, so only
the driver needs enabling. U-Boot then provides /chosen/kaslr-seed.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 configs/an7581_evb_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index a615994cc..3f8656f49 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -77,6 +77,8 @@ CONFIG_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_RAM=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_AIROHA=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
-- 
2.55.0


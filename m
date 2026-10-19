Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D5ECCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89C2280F8B;
	Mon, 19 Oct 2026 13:24:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sxIjmQH6LO8b; Mon, 19 Oct 2026 13:24:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C406810CB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416252;
	b=TRIs7Prj++t4wz7HPiDgpXuMA2D561QWgQeELykyKCthi1GP+B/r+SEdPq1ulurWDiy2
	 cu8N6WCWebgQ1Po/mCE2YfGvm5Vblh+LTVxYUPsK9ORO+VFaP6Bi6QcxPNf9SjDnhVPcS
	 7O6VjoyEPghukTdCAbPstVVWxsHPbb/tPpizjG7QTbrDymcX8Zd5qGeNdtNvUuUTfMuDr
	 uxWrWt9llzwJdi43WsSe+JmIFk5IfO2UC9aDExXM0BaUPUE7A2C2wd2MwvpphcY9LiEGl
	 ZnHohyRm2YoCkKJeDFUgb7UM1wgmXPqDWwKu9QeJIZ+R7pvrtHu7J4WeQfw31Htv3Tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Fx6dxQX2Y2IrFJjio3MfgL6pCzTh4usfWW5Uyq6l8Iw=;
	b=gmX90lS6F+CC+TK/gIJt2+Krf1Gw8cf4yv3BcqAqnLL0E5uc039DzOlebQZghg/v5f6I
	 VhJUpUQrW+6/nY7EpDvTR9GVEtdkLbQsow4zurpNxbnub9FheiUldsDPyzIHRr9gkRKoL
	 Gy5HWgwdGP3QJg8J1NBC8OGwTu5XMxCUD06huDrJpGJdKyOseyLMZ/8G/8i5UOeY2JZ9D
	 WZcpgRsZ1JY0b/I5P/raovs4qDM0Bcmq329UHM/9GXoGb+nmTuVkf1h/Ziv6PwoSrHQrN
	 lgsNxQxIcsr3z8qGgzD8UorYKFWFZkNszEMXu9t1MDNHsPYln4hgbn868+FPYBTTEOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416252;
	bh=Fx6dxQX2Y2IrFJjio3MfgL6pCzTh4usfWW5Uyq6l8Iw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n4PaPtN4UIL73y1WpqQZEwEUiGZtRmCaACiqKmX3jZc/sfcFRZeb/rlaOHDidkWv3
	 nmDMjOhXO1Hgxlw580S5aEA+uY3juBAgreZCBZH68/xj1BZIt6rz2rOHFShIZDeGVD
	 284szdRbHNlCLyW4nvMhOO52sOGsR85oTLBKxufvUzDHaT4gTN1JRvrTYeB/6JF//G
	 ymrQhxfjNA+fnhKqIr7DztGUz15XCfS1/C/pbh+neGvkvq7O3EyY9GmLSLXmOi3ugJ
	 srShNcEXXkZnlCY9wcM87EPisF2UKo9uCkyfj1iHK0obZqxcfjrGxIOHWo6poro8mN
	 aRHmu+7UTvrvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C406810CB;
	Mon, 19 Oct 2026 13:24:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 056071AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E78B4010C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:59:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z2uwLW3K4qoM for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:59:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 863D140049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792414773;
 b=A1KZYMDl0CpBcPHnfWynvgTB9ezPI7eaQ2y7pbxVuyRXY6j4Oc4jgKU/xRoGTBVCh+8R
 Ti4sscQHAkF59FQpS5wXUIr3HWWYY68H/FlofvN6YR343m0iUJyt/MX4AVuXywVeYMVNJ
 UIHJloNbAvcY8ymmIvmHs4ATJzyX+jY7EwDY1M6fvjG+Zr+gMssqs/k8s9dBGB6tZwevz
 b/AInV25fq+an4XwfvHIOyuxR4mKKXNWXSZOcxaBkhLfcjRYlX8Pr8u9YgDYsWmDieLq+
 XDfeqgEV79f0HhnFXWS67IFR8TJCAAkf70mngSJ6aowq8iGmMukt5n05cpQYGzwzs2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792414773;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=Fx6dxQX2Y2IrFJjio3MfgL6pCzTh4usfWW5Uyq6l8Iw=;
 b=oX9wampl/ykWMM1IPNc4ELfQ6vfQM0XG/h/fmF1e0N0Ocx9BM7OrX6TKMnnlS4Yg/QUn
 YRTw6+Zei53niRbzPK3XNcR4u9qVfVKEuW8V/HvDAhKmGYH/yRK53ztG70bOfi4+egZrt
 6ZhaCbYIYwA5LXgsCmS49H6Kojg21qo+vGKzrCDV4PwBGGXiG0PFuwQ0gZREeHf8TLIVH
 RxllKrKLMjlye7RZKiaR2doecU9wCtHx+eT/8cA/wFBLOSIomo1psTCE09+QQnHI7O0oW
 pt3NX55/C+oplpRBLF2uY0tGPNM86GpDpsMrKF17HcIz2bQ7CvV4sq9A52nShoK9h1A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fNdS9DlA; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fNdS9DlA
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 863D140049
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:59:33 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so16094005e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792414771; x=1793019571;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fx6dxQX2Y2IrFJjio3MfgL6pCzTh4usfWW5Uyq6l8Iw=;
 b=fNdS9DlA7mX2drVYaPX14pgV7QBimvAni5lfENPS8Pcgjw6GBvek1XqtiAVcOV3G9g
 3UbDzKJNuR4pXhjCZPRfv4XkPVIrVUgOYQ4fKQwhB0l+eXFbbm4Gpx8P3rwHp/Dv8F46
 /8JLnjAhszYNvjEsmMU3ZptXUSBh3oRETTQqtXF5U9S2+JPEs+0ytR6fKD2g3w/WjejU
 Q2vMOrnQhAoRR/n9R14WyeX/7l6eQbZgz8ZqVWdhqbNjMV8xeDz2cx4b1I5FCRE3WWTR
 WUaXsCRbYjJqOedhNvihGCxWJE6JzGR19qJf97Vpwc7mTe7LZ9p3tMDJsDSAf+QTfs+9
 iA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792414771; x=1793019571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fx6dxQX2Y2IrFJjio3MfgL6pCzTh4usfWW5Uyq6l8Iw=;
 b=eJqUX1HztvqA3RxazrMp3sNdVEMAJhkfWvv5p7bM9xhdFOkYKHU/3zjqpQH+FuD7HI
 GAzQ0u5sC6WYqfpv4eZSjosbRckmRu7ZnSHrJpP5mGNnPwr2GT/qk1rDUKmKxf2rMYDK
 Y4RWzzqMremwA6o3z/6e9lHqP9k3qVE8slcIiSdKCus7yXgmTdKqJVJC+unSnK11SvaM
 Z+EVw4leOZXs99QZoUArBHYtuAAKxg0sxuMBfTxpl76nszyAH/rN/d//hn6H2t5fXqBI
 kx1EMAWKBMpdrSu/g36yYTyg+jHTXfdkdRQMIkhIwFmqXx/gwxL8m1LrbkDCyi3XxqBq
 Tcpw==
X-Gm-Message-State: AFq9FYKftAFIdaN3J+OrJk675UcUGCH50kGX/tq0l2wsLNXhLzxJpM3b
 vWyg7UwfvSc9+UX/IJa2ywL5f8SrKQ90S6KcHdpLE6E6oY/T360A2S5L
X-Gm-Gg: AYBFou2CxHv6w4zHcfKEBvP/kpN1LC1YBXSfYjt6KzTHxRecRSnxqlWx1KFJmSsIWCX
 nACZtgrEcg9rD702Z7CU8MG8wIV4UW1QU7FDkm37zpLCYYDxaNdesUstSndo7zeDHcVGcaPERmd
 fLMCYwsACUfmIwhCp9O8xfhc/c6fiUoVC4Anea72yevG+HkKxi+dYCdq7obaNiqAkMVMG+gBL1t
 52R9kQjS/0D03Y3cy8bktODESMNJPWUo8RBq92hklk6GauC/3hXRhpYnypMini9IsepOa/15/3B
 3mJQaIm/+Gknk8wIHDBhsMJo8d2Myubuapayt4P2KFBvVI/bXze5VdJu/vPtC/0zxRQtC9Zeh9W
 PZrlBOxR8zOEke77s3uYQGn34CWoYAeqjBXdojioBrnGt17OFYD77hwSbAkfmUTsVHQsZKmitSB
 SDvlHfG6sxoL+CgGfBiIL/2r8V4Rhvtd7W3u5mWn/LiFrTCpriulxrdVyFU2z+B/cK
X-Received: by 2002:a05:600c:4684:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-4a1d76001e9mr154018605e9.16.1792414771159; 
 Mon, 19 Oct 2026 05:59:31 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d30d778bsm264696755e9.9.2026.10.19.05.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 05:59:30 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, stefan.eichenberger@toradex.com,
 francesco.dolcini@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 0/2] imx: mach: imx8: fdt: fix industrial GPU frequencies
Date: Mon, 19 Oct 2026 14:58:51 +0200
Message-ID: <20261019125930.111608-1-eichest@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:23:57 +0000
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

On the industrial i.MX 8 variant, U-Boot limits the GPU clocks to
625 MHz by patching the device tree of the kernel. This series fixes two
issues with that code.

The first patch makes the helpers return the libfdt error codes, so
missing nodes are ignored again and real errors are printed with a
meaningful message. Before, booting a device tree without the GPU1
nodes printed a misleading error:

    Failed to set assigned-clock-rates for GPU1: FDT_ERR_BADPHANDLE

The second patch adds support for the GPU0 bus node name used by
mainline Linux and NXP downstream kernels starting with 6.18
(bus@53000000 instead of bus@53100000). Without it, GPU0 runs at the
default 700/850 MHz instead of the 625 MHz limit of the industrial SoC.

Stefan Eichenberger (2):
  imx: mach: imx8: fdt: return libfdt errors from helpers
  imx: mach: imx8: fdt: support newer GPU0 bus node name

 arch/arm/mach-imx/imx8/fdt.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

-- 
2.56.0


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6ACCA5FE6
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 23:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCAF060D96;
	Fri,  2 Oct 2026 23:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HYgFiCrTEsvf; Fri,  2 Oct 2026 23:49:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1C9FE60B2B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790984970;
	b=eN6c0awF1LRolU8ZKGzS/LhtHX+giXLSRXiFBmxhwM8z0cygBDZnHFlpv6LOu6wqMJ73
	 CiNYdeQusNJsuR3X2a77C4lrc9XgYd5QkI0GuSeMN9gCayjA8jlDULBkakoAqp1Sbr+pB
	 JwfgqQ4TU+qK5GWs0kZscy97hY2za5caRgECog8ktBOmNykWBtTJVDvCPovYYYab51y6T
	 BzI2Kd0I1oeR7pe2B+GH46upgC6X1mCgKWZ/JtloFrpIyubO92qwU1og3hQDQzg9qU3r6
	 VZH8ncakAV1Np9OSGAi/DKIbVLM6iCiUtj2m9ubog0V9/iA5GQO/BSnAUJpuLz8QLhQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790984970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+H/3fUEOBq2LUkHXlX7semHXekSdLKm21YgWQpMlz6U=;
	b=kw/h2XG+2jWJWKA2Wn9EW24bYVvD6qDABIFDDQHp2TEoBaMqxirv0wLaQ43Q8JRS7nyt
	 8v59sTfE8GSTQQpzV5YlgVRg1J/9yojq6eXwEkpRiEIzBhxgAomSetdqURPKBfCGhHGj+
	 9gSm7QpdKOXvKENifWYlvDu3HjgdrXDdeQQCJDuR5/Tr6KShAsNo6oo+Dt0OgYIlPEYwV
	 kVtDkoOkMkYDJDnnS4WECG3tPuVrKPDpoaTZYV3jK2iAu1FE4qv/bsCw6NZWyqCRSHmrk
	 d5kkf3esHhBAJcBkfI1LPDG+gLEMn3pL3hCzPnsAZVgr0VsxV1VGu4TK4hukAWYQLXw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790984970;
	bh=+H/3fUEOBq2LUkHXlX7semHXekSdLKm21YgWQpMlz6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nttWnLH3hELciSCAm/qRUOTxKtkOPezZ4ADz2CU1sCeMLeCI0XTpZtuTAoCaCB8ij
	 MCUhqWM7Y7zO9PsGQrHi3dF2gNACxxbBeerusV70ORd5tIXQ5SfzyKeODd8LbcZz7l
	 2QEfCzKMnKU46oEq/a/ww1ua4hR0nEjRA+cYxD1rLEubBv43U0jDMq1G0FS5Iu3gef
	 nu7fYuz8szmcg+sJSwUerz4J7C6Z8o0ZlpKrxeZWOjwWY6SVkva3BwRRC8nh22NY6u
	 qTf/mYnR5vhrRV9AqrIhWNZlkrjiuoUVRcF4M8m8oZtoeCswiHoQSezSd/uGQCaSNq
	 s7mhbHfDNn8xA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C9FE60B2B;
	Fri,  2 Oct 2026 23:49:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 793F434E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 23:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A92A812F9
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 23:49:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YTfvkENR-0qa for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 23:49:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A76A6812F6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790984968;
 b=iUJXpbpUp+Mu2nbXmY4r4YVDmpoxfyrRVhuBmUSspwdz2A3K7DWMYHM0SU5555mvlMI4
 vcoZ7/9ERtaHSEkrrFbI4lO0FtoORYC1A7OdaDjWF/OgyP6141XYRW5Usywm+h3oEVyBM
 kzRPT/wz28tEf1J0pag9pqPQ51usm/qVziVwQDXNQfMt2rrEEbTk6HID4wC3twL/p/7l2
 E7dJmYKTutoJXmje2/OiW5uhpnXTTk9idJqaUd7BWNdGb0ju7DbRFlgse1UwYTOZL7C+f
 bbFV0oIaDv+infC+yYekTkDZVR8axvYeg6z9GDj4sjzBdf0yb4qriVZRid3FOmlfqPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790984968;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=+H/3fUEOBq2LUkHXlX7semHXekSdLKm21YgWQpMlz6U=;
 b=iKKVb5P2U/cBVRQl51ZHdNt6B3RlF1fdWUcNzQIYsyqOZYKmR08BBfhKoS0NnNNBJrAa
 g/DZV3u7mPLNcMaqLEpTbk6vomnNZAnip0LMKRGA7cmGcIKWJXJ3taCe4QRyr81tXAxsw
 Y7qb4HGD0Oml4KsaMzhkfLll14Q+9JObIUYk4FLYTbh3Q0sKytBjm+hROXKxbtXgXI7z2
 7NyZMFKXQEnth4neN5/n1O6svcWfKyji8qefx7ayFHrJyMDQG1vHtQOgthpo/b+PYsdiy
 w7ZWmJRSDrAtgIwUHA1BxZjSFbK2JkrZ0SGvIi1r+lbkn7NKLeByECoxHnESPThEfJw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ClSD1e4d; 
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=ClSD1e4d
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A76A6812F6
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 23:49:28 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-483a66818edso43035fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 16:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790984967; x=1791589767;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+H/3fUEOBq2LUkHXlX7semHXekSdLKm21YgWQpMlz6U=;
 b=ClSD1e4d9Q95hlocF3i3PySq8V2nusi4TZMp0yJXtqRNoi1kfsVYTS6udXbURTeu99
 1aWAk1X+v2zjxz8EFpoIkY0MJybGYo6oiyz3/sxP4e7Jcp2IgEuERhMLykNFbOQv4PzO
 ulkMYqzRk8AY9DEpgSD9/bgPlhhepo7+mQlRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790984967; x=1791589767;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+H/3fUEOBq2LUkHXlX7semHXekSdLKm21YgWQpMlz6U=;
 b=uQMHnjXtrBceW87jOMHCaKJWjnmdqkQp6XRmz8z/qSJYwbBoXVE/VaH3sHpdh2FC9S
 UR5SD4vi8j+t7BX/01CYuEH1hn9/DsJ44bA+sIaOcF0DPDBvcLmhM5XoWxaQzhwg/C83
 vZCQo/0gqd6sVHLZbLblT37Bp5y5KgtFTNfYdsVSDMI1/AQRmkw2KfQFK1mB+RZUyIpp
 xlTLPrIU6yulJ0J58EkDWCq370is3K9EaqGpxm+geBdvW4SE0GC9prbvQx2xAbkz+CmJ
 tLpef04xA3BVhpxhGvG2Jvr4874CYtCS0sAw3E9IIxQ3T7oM8G0vpeYVOPq4IN6h2YfI
 C/bA==
X-Gm-Message-State: AFq9FYLYnFExF8ijB5VGXlHHUScQLUlqiKT9LbZDLgEwem1x2aRT1lFY
 sYQFOs/QaWf8snsVnN46BvsoHhPnqV7E+6HsQV6VieJf2uO/kp87/wRSyFNeX9dpPfcnSRKUuLO
 +xHqyHhsKq9QC
X-Gm-Gg: AYBFou2iZHqXpzfEGCQDEPASGh0DKEdYBcBGa5LVNv2s9plk/flQKukjBMWDz1d8E0w
 WPp5JNk3B5Uf0aEZ+Co2pBH9L9d+O5IgeMnEcN8ugSwJz0ZW5YetQ+QPJMEw/3vir3NuC6lyNQY
 yHKfUkBSgj0ByZS5BVhfHvfGHro64m7j5UiSu3fO/weKHd6Xe+duZGQfD95tYXacamu9U2QStlI
 PQpF9CQSp3GadjuMjv4odW5b7gWMsu/XT8/ew0jHeWxQxoO+uOF34PMW/2zbValcaWc7pHXwvSG
 hYkxHxz++Vtmg6L4L7+dfs8kyRKFMuntFH32CfBW42jWSRHCVvXssNvVqLdYrIBL3YTHPB7dH9g
 vDWcXVGYos1QaunraxYefBIIKaPP8PPW+KfygJ+Bf0tox5dZQbJdS1X3A8SqDDZtWYf/s+MT0Q/
 c1nywf4QqXMluSaLUpbCfrwFfdj0swlUOlEhEKASiY/qd0cWCd+PD0ZKpviVchFx3VH+CCHt5hM
 P/I6V8rzHvCB4n+Boq4ByJOWouvCtjpfNM4FMsBp8qynTNZn1GbJiGrIDMnCPeelN3TiAOdNYOD
 1/9K1HSfTlODRZJXMg==
X-Received: by 2002:a05:6871:711:b0:48f:e0e5:a1f6 with SMTP id
 586e51a60fabf-49e3a9373damr774678fac.42.1790984967367; 
 Fri, 02 Oct 2026 16:49:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49e16e1d0fesm3575316fac.8.2026.10.02.16.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 16:49:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: casey.connolly@linaro.org, dlechner@baylibre.com, 
 stefan.roese@mailbox.org, peng.fan@nxp.com, Aksh Garg <a-garg7@ti.com>
Cc: u-boot@lists.u-boot-project.org, s-vadapalli@ti.com, danishanwar@ti.com, 
 u-kumar1@ti.com
In-Reply-To: <20260923100654.610596-1-a-garg7@ti.com>
References: <20260923100654.610596-1-a-garg7@ti.com>
Subject: Re: [PATCH 0/2] Add support to auto-probe Torrent PHY driver for J7200
Message-Id: <179098496553.3139846.16985433197473079570.b4-ty@konsulko.com>
Date: Fri, 02 Oct 2026 17:49:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 23 Sep 2026 15:36:52 +0530, Aksh Garg wrote:

> J7200 requires U-Boot to configure the PHY unconditionally after binding.
> This prevents any rproc firmware to configure the PHY, preventing
> multi-core race conditions.
> 
> This series adds the support to auto-probe Torrent PHY driver for J7200.
> 
> Aksh Garg (2):
>   phy: cadence: Add optional auto-probe support
>   configs: j7200_evm_a72_defconfig: Enable config to auto-probe the PHY
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] phy: cadence: Add optional auto-probe support
      commit: 920876b975202ec0d7be35da5914c02624a4e8bf
[2/2] configs: j7200_evm_a72_defconfig: Enable config to auto-probe the PHY
      commit: a6d44cbaaa6955d1d3b43614a4ec4836a4bc939b
-- 
Tom



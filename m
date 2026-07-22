Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1B3C4453C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 16:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A43080F24;
	Wed, 22 Jul 2026 16:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id If7kyxteqOLS; Wed, 22 Jul 2026 16:54:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3A4780F14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784739255;
	bh=Qg2bhpNt84RqR1TT1avI15MyZa9CMOPcsMBaSXGbavk=;
	h=To:In-Reply-To:References:Subject:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=lJRNhmz+SPklAQDYdcvx4tdlepWtF/Sh55mVp9JBIIPXCQlZgD5cGgpHkI2Pqh5k+
	 2f6OxGYf6OH5odqsuIVW7Lp6MlDHzdNVjIs8KtsZ0tp4P+Bd2HKl9T2X+EA0QR0d96
	 A3ZhJehyEQqIImctveZQqrjh2k5TAKHtihFevXOZl5oUYmAa/a7T0Pa2m+S41ZX/EO
	 Omj5iBamYiiIen7Gm/UaeYeHQm2P4JgG0gh/b/KGYuYwP+Id3t78Hl6DtjLvFTpqXL
	 xSW6FnmGJHQX0drpKBUD2F+WYhKSFh3f2Nm4HP80AZJq2SFazog/b/Q/WZp2JZW98b
	 c4Scs46KE446A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3A4780F14;
	Wed, 22 Jul 2026 16:54:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 02735313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E8D01407A4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tRceoKvhC-dK for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 16:54:14 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A9B904076B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9B904076B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A9B904076B
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:54:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 145EB846A4; Wed, 22 Jul 2026 18:54:09 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC5CC83E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 18:54:06 +0200 (CEST)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7eb34c17b96so8474546a34.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739245; x=1785344045;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qg2bhpNt84RqR1TT1avI15MyZa9CMOPcsMBaSXGbavk=;
 b=iLhEZyV50jSJRrif6elQsbdFppj8GMt7V1SJbhTcjf5XI5FwKHPEu5KVIu7MxVYwxw
 oyvDCI315OOLb0Ao9ARQwkp4h8L3yG3izSRH6bqvb6UCaCfyDOK3p6HNC9goHyLCDjdX
 m74subevH78h67An90ge4XtO6vmX2iOySybPdDLntJDkBt9FkdUg5P0XT697tauY4zR9
 GVM1QHvB0U7svOziDdOGfmTtp7hFlgClrZ1PxruwG1ZSd5pSPso7dl7hZ3UZcemTPdHn
 8Gbd3pi8WSj4XspC9PtBWkZb1wrJ3h5gfXXyaXQ3O66BLlKvR2UTobd2SLlbyZWk8tCu
 VUTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxOHAci5CE9sMeTrsr8Trmg5VqwRszNCF6cswAAmBalAeTh6bFRYHZqNq622Gq/5A8gE97YDY=@lists.denx.de
X-Gm-Message-State: AOJu0YyzARHAZVXiYViEZKO3Qn837xhgjYWlMFGvB5w1f/ieeyOJ3HEB
 rhj4W6zkLT80TupV8nzTWXNezUeW7BSOmO/JdBdAoaeinJ9T2G66CdFkaWG5VadSSDM=
X-Gm-Gg: AR+sD11ReLSg6QrVxEqaM1SFLpAU2QzUkdjWvEL82JyymzLdX5HMyJ0F5GgCmuuFEUJ
 6KY/Ud0yLbGnnTQWyae43fx1p6nAdew+aFHj137bvLERQXW/7GVF6sVdmXBBw1lv4wqImg5IZpD
 iae0lRZwM5sgXFGooOocMtv5oY7CjJkzvLrbAaIFu+UP+Kfl1pmYJa3HPUNx4b+ekeFW3IHKrdg
 sDKksdy5Nbi7YVfdmBtl4ThL65qz/vv4MItiLjJtB49vmyfPcZVoMIrJZBv5ikfJNV9n4c9ZpUf
 ld8j3pY+P0/nOZo5oPOE+foLdIR0m4qfZGHX8l6Jp8bbEYJAYA2kDc0wLW3ClYe5GqYUv7Gs7gP
 VnLFAqqfOn/5f02i/i5Y6MrGw3Sgq08pL/LpviXxIOzPxS+Dfu7g573XSAcT8RCcuAbaqQtQyko
 YHdixhl1n8EofaaK+1
X-Received: by 2002:a05:6830:3590:b0:7e9:b4d0:5399 with SMTP id
 46e09a7af769-7eda156bb81mr14149641a34.26.1784739245442; 
 Wed, 22 Jul 2026 09:54:05 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d067:7d1:556a:2be5])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee29db53fdsm1684657a34.4.2026.07.22.09.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:54:04 -0700 (PDT)
To: Macpaul.Lin@mediatek.com, jstephan@baylibre.com, trini@konsulko.com, 
 jmasson@baylibre.com, u-boot@lists.denx.de, 
 Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20260706133322.68010-1-ccaione@baylibre.com>
References: <20260706133322.68010-1-ccaione@baylibre.com>
Subject: Re: [PATCH] configs: mediatek: do not autostart the watchdog on
 the Genio EVKs
Message-Id: <178473923299.3352940.12255892264720918355.b4-ty@b4>
Date: Wed, 22 Jul 2026 11:53:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=361; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=agNVZ5J/ir+Q1T+NO0bOHcYj0ElrOW+WdGskHjE4VT4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqYPWlR7LSa/7d1zT7ZFjWIeJyj4VXI74+tBZXt
 otdfFJTdcGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamD1pRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A1kUIAJcMeSWI4s5BRpbK75xmnvjfY13zBrLcZscSv/n
 vJOOEWggq2uhC4JCJdl1Rb8lrGCri3Ig3hWUlUpWwhL5Dh835p0uGHrveQ01YfFvLj5NWpLSs0u
 m4AgYL0cOhM+Oq1AZo/yreP7DS+mwAnziU/TRFYyTys3y5yTKjbenaWl+Z10duJJTDkf4SdHVQk
 ndnMVP40u8143wGw5vblIch/QjiSgpS75/FDCxc6eP+wSwh+KVkb29/wT04XtoGJlcr02WjFTTK
 V72pZyelnvIF5ziBUANZLghPjEmqdGeNjLwZ4L6A5/+ZcwphP+Yuz5Ems9ihMrVvclhyDiEW7Jy
 3u0w=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784739245; x=1785344045; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qg2bhpNt84RqR1TT1avI15MyZa9CMOPcsMBaSXGbavk=;
 b=Nq3HNq8VZ/yCK4GhxPY47vtKgIQIoZTe4auCyMGHc32YTQXtpSAEBHJUEd+jGgk5gx
 zwSmld2T2t57t/r+zhOGaP6pxIeaZDLVczOuTcENyEsZk/t+ogSyM57FthFIXrWE+ogw
 89DcnbPIWhKkY81CVC6Bica41lVwvx+1PAF8Go3tL7KMO2sFakK9cIn2cqGCm30TeLLQ
 7at+Q0g+UpsmQo1Baw0dLEwXVZqGF35pDrdLkW+6GaEWq277Y2UPO0aliFFzTowUb3sN
 JJX75dmjg0mD1juObd71ZOGGABkZGCi1J8PAAeyBlpNr58PZe78knWZD1Bx0PFCQ5VZ9
 mlww==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Nq3HNq8V
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="Nq3HNq8V"; 
 dkim-atps=neutral
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
From: David Lechner via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: David Lechner <dlechner@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 06 Jul 2026 15:24:59 +0200, Carlo Caione wrote:
> configs: mediatek: do not autostart the watchdog on the Genio EVKs

Applied to mediatek-for-main, thanks!

[1/1] configs: mediatek: do not autostart the watchdog on the Genio EVKs
      commit: f309d23e3a171d56a4a6c2eb21588a370b8c811e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


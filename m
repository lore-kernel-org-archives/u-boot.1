Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7F6C27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 07:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 140D388216;
	Thu,  6 Jun 2024 09:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x9wHh5CY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC59882C1; Thu,  6 Jun 2024 09:12:30 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCF1088216
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 09:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-354f14bd80cso540379f8f.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 00:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717657947; x=1718262747;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UW9IIiVcscOg3165zFGF1SPoQULgvPmfMzeLhrLcvHc=;
 b=x9wHh5CYtqKBPUTc15y7SnlSPcQ3yicfUyL/04O4NgWjixMlEvvRQfCtLT3BL3nshv
 wZWbzMTD6l8gJqiC2r0all+9HbrwXeYt4TQCu9m4cSTTkzEJLbwiSxO0x++H6E4UqRyp
 TOwyBkrEKV9BlFLHHS78WYxnWNr5QoXsS8AmDaK7/D20pzPxtOA8n8SFWTfNyn1VUd/0
 Sn/WdkRzsFEI67gqwYNAzXBdDe8kjpA/XRecZ3a4pd6O+p47hoEsWNOfN/REU2bhpM9U
 sYoxsktRkHHRxV2RettKvvnjfw7M11ZPA/WGXHgJzukzsuPc9M2sUR+l8saztfG5dDnH
 aHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717657947; x=1718262747;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UW9IIiVcscOg3165zFGF1SPoQULgvPmfMzeLhrLcvHc=;
 b=VKeR5FyrBHmUl/wLMExREbGApnOKw+Xwgv1bs4NZmQI4n9wLx/uuKITTm65QF/Hunm
 vNhHd4w8CHZpH/8v0DXpHlf53r4vNT0PKozxJFyO2oLMI/JGhpm5EOBzPbY8BkVbAX0c
 xCn6DcWyjl0QuxZ+2W/HO41STQWItgIKvR7IMymYhKqGfE0tLbN2psbV6J2VwKSSWKcz
 G8fYqTsIRlxBYcXWf5jvikXNtnCv/1hXbrb2SzEFYajSn/H6iYJpWIluuneW04l5vpym
 Jc4zWJ7hxLMQrDuxsgL/yon9vKGV6sD1PYbpb+yl+4wYM/LnddPK+QTLptDYSbOC3HVe
 YWUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPImJA5dCU2ruBLDLR3n2pCr1mlJJG0Ga4ngjJCUd2YkERGWvnMtBiOJyIFITcYbYcp9Xv8vjnIm3iM/QAR5cfr8xarQ==
X-Gm-Message-State: AOJu0YxBtth5e7U0IcdBGPBFQavz0Tm0Vhwvq2F9mEzUwrEX8M083HZ5
 Urajvvvmf3HbHnn10Gy22u2vTSx2uegWPZJIMF6hTLlK6ID3s0DUlUeE377bUR9ypNfLh3rzzP/
 oses=
X-Google-Smtp-Source: AGHT+IGTyX0IRqN9zGSactSC+Gpra7A/52o4sVERpDPMjx+x7057PiEc2lim1P4UJET8NCPgMSqLWA==
X-Received: by 2002:a05:6000:1d2:b0:354:f90c:63d9 with SMTP id
 ffacd0b85a97d-35e8405dc4dmr3308065f8f.6.1717657947084; 
 Thu, 06 Jun 2024 00:12:27 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d29508sm764998f8f.4.2024.06.06.00.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 00:12:26 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, u-boot@lists.denx.de
In-Reply-To: <20240604054425.105902-1-heinrich.schuchardt@canonical.com>
References: <20240604054425.105902-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] dfu: add missing dependency for SPI flash DFU driver
Message-Id: <171765794606.161006.4352011938653246906.b4-ty@baylibre.com>
Date: Thu, 06 Jun 2024 09:12:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev-b6b73
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On Tue, 04 Jun 2024 07:44:25 +0200, Heinrich Schuchardt wrote:
> Building the SPI flash DFU driver fails if SPI flash support is missing.
> 
>     drivers/dfu/dfu_sf.c:123:29: error:
>     ‘CONFIG_SF_DEFAULT_MODE’ undeclared (first use in this function);
> 
> Add the missing dependency.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] dfu: add missing dependency for SPI flash DFU driver
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4339138a2086f8449b9356130cb6e97a81aa8679

--
Mattijs

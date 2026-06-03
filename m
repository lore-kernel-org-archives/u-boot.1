Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8636BCD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2737884931;
	Wed,  3 Jun 2026 18:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B+e0TpAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50E2584898; Wed,  3 Jun 2026 18:22:52 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E96B848A9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45eedcdaeaaso4700150f8f.3
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780503769; x=1781108569; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/nRtYQhZ5RgyHxRa3PRKaA7QFUuQolTWPBUW/qd+vg=;
 b=B+e0TpAZyWUUeZKuDtb9IOATkA9zkJ/IOCHs/AHxwdiIQPRA03AmPtg65v1eKkVFtO
 qgBuJmfiE0N4H+HOjo9jY3HzCaBkIDVZpiNMWTiQMyrqRUStv41fA0KUT6nyTeAkzGyN
 r/4cKsRSVo1M0M9TkcPcsqeU0PEvyn/J/2USU7zYRINXerzjhKN1IT1MpGjZ8qCtBy4N
 QSQFhZHuNaz/ulYguhZg53AnvNdhxoFu+K7TfgepCyUYMjEK4EY8j1971APCOVHT/MaR
 mxSN4scGYAHixUzg0+WKnBwZCNSY6o6OR/enOJxuO1QCs6uWo5NKx1ddb8r7vAZrMJ71
 EU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503769; x=1781108569;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T/nRtYQhZ5RgyHxRa3PRKaA7QFUuQolTWPBUW/qd+vg=;
 b=Bu2D3kKFqzFMMMctjaTCoZGt+8KFuUXVRYrCv3w51XGS50dFUrELzL/waP5QrLME99
 vuofunNK04lTxQgKFze2NX7ggH2XSoGTHIsVJfCTeuXOAOx3KoYWsPyO5qnYl3my9CVH
 SV3mPlrQr4DYJyTHChTp7pXLyocphTtYp7epWYp5vvh67WuLOoiUforP87vMOPPH1UIK
 PXolID9szBCmQFU4wXXMYa6IBQ48UCIkI1U3WeClltjF/ZykIYKEvQwWNLdn6dOChhzr
 vOg2Tky6U9nDAbpRqUPvjQ/LhxLUbajeOvjz4uk1aPtAk7qi3uzco+RWg/CLqVEri7wu
 2rCg==
X-Gm-Message-State: AOJu0Ywj/SJL+g+i136me52vgce82sfbjGBInuDvm6ZWxCARDCYH5B1P
 iFkFzPvinWbaPORvhJWOSLRqBMpIxj48sUfz8zPN1qogeMviDQavS+6r9lM89IoZEidTMGgJ0PY
 nmc6B
X-Gm-Gg: Acq92OHzKuZ/f9aYsvnK2/3zprGNdbbizjMiD7mhikBcnADLQno//jkjH5ky87QATWI
 DzEbKCPEcUkF9NOx/hiSPqO0AJqBr/3j1lDnkN/1PpO6EBG33p37Xq97vCpCAhhgcnMApD9jEOH
 3JJfWS/7SfkrYLpuSeEyAycvOU9BWoriliq0n6M6IC4bfcyUU+hlkFLILqIaYsi51Z8lB9abbqZ
 h4K77t8J304IzT5nXXZPNUC23x99vbxZM1LJEBIMd8oDrdtaf87ygBV/qH8DY0ep4m8FDpbtxn9
 sdKY0w80pmGK2brOwdqPjFTYkEYglKuRk/7nplU62gTvpEHnsObG4MYav9OekKCQONfTxYg5xQP
 N0MPbxizWabcZ3WHMs0Hnr0YJ4uNSDGIHt5NQ0uMYcHnP+TWf78hF3kukh+cp20YUebuCXxSwB/
 vScz7MJmIJX8+zrBPoCHmfAtAJEmB8MN6xAokefeC6TtFkrV9zZ72e5C0=
X-Received: by 2002:a05:600c:5288:b0:48a:53ea:140b with SMTP id
 5b1f17b1804b1-490b5ed01damr69502345e9.28.1780503768806; 
 Wed, 03 Jun 2026 09:22:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b7d6b990sm33713275e9.2.2026.06.03.09.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 09:22:48 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, dmukhin@ford.com
Cc: sjg@chromium.org, trini@konsulko.com
In-Reply-To: <20260529034441.2075305-1-dmukhin@ford.com>
References: <20260529034441.2075305-1-dmukhin@ford.com>
Subject: Re: (subset) [PATCH v2 0/6] nvme: few fixups
Message-Id: <178050376829.31799.12135354143512492180.b4-ty@b4>
Date: Wed, 03 Jun 2026 18:22:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Thu, 28 May 2026 20:44:35 -0700, dmukhin@ford.com wrote:
> The series adds few fixes for NVMe subsystem.
> 
> Patch 1 adds logline for tracing misbehaving NVMe drives.
> Patch 2 adds plumbing for blk_flush()/blk_dflush().
> Patch 3 introduces NVMe flush command.
> Patch 4 enables `flush` for the currently selected block device.
> Patch 5 makes nvme_shutdown() symbol public to enable use of it from
>         board_quiesce_devices()
> Patch 6 tiny fixup for QEMU command for manual NVMe tests.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-nvme-fixes)

[1/6] drivers: nvme: Log I/O timeouts
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/389363d287585d8135a554c4419a4f580346b9f8

-- 
Neil


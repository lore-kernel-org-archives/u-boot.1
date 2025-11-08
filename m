Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A732CCFA18
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 13:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3454883E8E;
	Sat,  8 Nov 2025 14:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gX36BU5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E0B583E85; Sat,  8 Nov 2025 14:26:08 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3912383E83
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 14:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3e2eeb85822so906465fac.2
 for <u-boot@lists.denx.de>; Sat, 08 Nov 2025 05:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762608365; x=1763213165; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNRzcK6k4nlRT3+M2h9Sdg3gCQYexXcNn0JiUS/wgZU=;
 b=gX36BU5dB7Iz+O8sNZIKyZg0PqeNCjcxg44+CVD7XB3as5umfZJwBG1KPIA6P6fCF9
 fAFXclL+dVy303K+hFQCI++DE6H46Euqvoc5lp3aiFZFbi+WkLdoKVyDcEfJUaKuFCq9
 lr4PMttX+XhgzPq5ttilcpyycGotOjJRi9ifI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762608365; x=1763213165;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WNRzcK6k4nlRT3+M2h9Sdg3gCQYexXcNn0JiUS/wgZU=;
 b=C8ooun1pQ3C5qaMShx6dwGmhZjiQeM45eaTDJX6HNpP8xc72sUX0CScr8Ex4E4l6h4
 DQZ/a/Jrd8PSfsyTZHunZJdyI0rX4cca9/5YKp1WOVzg3NdsWhIEmtDAKYnI/G6SjfQo
 HrRuq0nT5BTReaFt/ruf2QPckFyuoZKPlVFd93k4B9YrNqxZvCmRGTCvko6yn9OL9S9H
 2NUQ6V/wGGs8lvKsnPUQ/In+pNZJ6vIt4jBTEnHONX22US0e2trUOE7CuBV1Sj+3lLqK
 bUOCB/xDwnvUDv9lwkyuC3BSEKQaHjekkg2gjmpMXF2jKSvlBopK7fxQV+QStRjx43hA
 UDtA==
X-Gm-Message-State: AOJu0YyqsAy3a6wHeHsCmicWJS9ODgGzH5C4B7vKhYQdEhU9BT4Uf7ug
 g+Z/2nipxbGSVqX9uCx5VGN4qvLTyaBEUysJJoYu4aW01g5vNqCjoakUHlEeeOgPGvQ=
X-Gm-Gg: ASbGnctwRG/e1T7NnNLjGvSD6Pj8KHLYErCAmqgps52Q7S0rM9Srps/M5RRBJpqmRt6
 vWZ//0DkxS4drfH/BMVUxEZZ8pczC8m67XYdxNv2/gNYHG8dbNuyqiOUag6iu3PAUtQuyTmhkPj
 qG+maBF/hcG2clrJ/XhfXlKh5Dd9auk2OLETCSVZHgbrlDKYyUwgbAbFt7dgSMA91SHqV2bevXy
 Zhcg5e4MfEQh8mSoaFucL1s4bBrnypgY9mygLh7NQHxdDnWejAtppP4Bn5etSJt2QzuNlS19QAL
 KzT4boTb69e49Tu7dMdeNlnFCN4RT9jQ6PQcreQt6d66Fzm010Oswns/DYSsmjG/MNgHo99h2rj
 55E/9p5CJhMF3UIZ42hKLJOKHR0v/ol/17qgDvLeOdEP88xvV4W0yAOtI99GdmHylxxrMpE3Ori
 IMXvOynzSPba56TpV+Uh0gWN37NuvVDhdgBUyQqRG9vNd73YgM
X-Google-Smtp-Source: AGHT+IFeDF0QSfQuLqTCqVMy8VhPVxgCuw6I8JdXI2V8DUbYnleIlRfnGAnI+tOYBT9sVMgaaMwU9w==
X-Received: by 2002:a05:6870:214b:b0:3d5:c64f:b726 with SMTP id
 586e51a60fabf-3e7c24ed00cmr1268944fac.17.1762608364959; 
 Sat, 08 Nov 2025 05:26:04 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41f13a512sm3581636fac.12.2025.11.08.05.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Nov 2025 05:26:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: a-nandan@ti.com, rfried.dev@gmail.com, marek.vasut+renesas@mailbox.org, 
 n-francis@ti.com, u-kumar1@ti.com, s-vadapalli@ti.com, 
 semen.protsenko@linaro.org, jm@ti.com, bb@ti.com, 
 Hrushikesh Salunke <h-salunke@ti.com>
Cc: u-boot@lists.denx.de, danishanwar@ti.com
In-Reply-To: <20251023114604.3655625-1-h-salunke@ti.com>
References: <20251023114604.3655625-1-h-salunke@ti.com>
Subject: Re: [PATCH 0/4] Add PCIe Endpoint controller support for TI J784S4 SoC
Message-Id: <176260836321.3710933.7508553895249434616.b4-ty@konsulko.com>
Date: Sat, 08 Nov 2025 07:26:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 23 Oct 2025 17:16:00 +0530, Hrushikesh Salunke wrote:

> This series enables PCIe Endpoint mode on TI's J784S4 SoC. The J784S4
> SoC features two Cadence PCIe controller instances (PCIe0 and PCIe1)
> that can operate in endpoint mode. This series adds support for
> configuring these controllers with up to 4 lanes.
> 
> Key changes include:
> - Adding a stabilization delay after power domain reset to prevent
>   timing-related initialization issues
> - SERDES mux configuration support for proper lane routing, which is
>   essential for SoCs where SERDES lanes are shared between multiple
>   controllers (PCIe, USB, etc.) with different configurations across
>   boot phases
> - J784S4 SoC endpoint configuration with 4-lane support
> - Disabling unconfigured endpoint functions to prevent enumeration
>   issues on the Root Complex side
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] pci_endpoint: pci_cdns_ti_ep: Add delay after power domain reset
      commit: 352214e8b2fadae4af7b7d9c849af24a7350ab2b
[2/4] pci_endpoint: pci_cdns_ti_ep: Add SERDES mux configuration support
      commit: f0c7d4b4c637a3ae74f71d4a4b565e8ba999d744
[3/4] pci_endpoint: pci_cdns_ti_ep: Enable PCIe Endpoint mode in J784S4 SoC
      commit: 8692f48baad3b94357dc6fd114ebed8c633637a6
[4/4] configs: j784s4_evm_a72_defconfig: Enable configs for PCI Endpoint mode
      commit: 6176174ab24443d271bb507f001551f86bf53cca
-- 
Tom



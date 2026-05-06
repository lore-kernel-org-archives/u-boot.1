Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEA2CD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 11:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D160C848A1;
	Wed,  6 May 2026 13:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lqVckjvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BBA2848CE; Wed,  6 May 2026 13:00:31 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BECFA84897
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 13:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67cac5ece75so4650632a12.2
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 04:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778065229; cv=none;
 d=google.com; s=arc-20240605;
 b=FCovPYZFMvMdZz9ZBxYg3B/RVdX3JggbSCr5B5cwjriLER+7+Rp4+88T27Gq8x2sjg
 EdKvzZ15KVINMRAuEejg0ywY3bX70Qs548ogHNxMEVRLMaeBblzDyaYuX0z4nGKBGjSQ
 XL1WdpUJL9AUvPLebGE8k0ERxyZEmjj7t5HmXo7gGSjGO+4KkC5+yXT2n5Gi+2DQfKqY
 AO0dWVjk5e1vRO2i4Lvrw3PldhOFN2FY0Ej98IIJUr32w08Kd2fwcWliauRkHm9PfJXB
 8qYF39qXJqLPrA/hL166nzoF9jVOUi07VCD1PHXlioLDk/ZV45kGKxj2MElkFjJm8IXP
 hVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JFiz2Or0WaK7+tKx9mItvJJAajfyKQwS7ufCydXYXAA=;
 fh=Ms12lXF2kWpLRnNam1t3EWLh33an/Sm0ylNa6dIA5Uc=;
 b=ljjzNAjw6Qlklhik8lX3FA7aqsIdXmIFwUh7nbQtW3uttAzk/E6msbKNJ4kwYC782d
 51767VfWhpVlAQyHWG1dMcHWTkmQMdPWAt3/TngkuFvUpTZWXDBnIcReugoKM8pMxBao
 fp1CMztQtapsl1w6Fje6xyB73x+83Us9J19rY6pllHKdElGSOrkqIsrDzOV58ks1knpI
 /ql6qKvTdvsDB7uN9agEs8XTA+yZJ92hG69h8lQgNTsksBSummty7igS2kFd/ChxoA1P
 RbJqHY8JABs3EY5EwuKR4NDgtfU/ZH6vzztE0gjzIjyDqz+N92zR40qpmf7ex9raA+Jp
 OMfg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778065229; x=1778670029; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JFiz2Or0WaK7+tKx9mItvJJAajfyKQwS7ufCydXYXAA=;
 b=lqVckjvwuNuBDJEKiD4axwf8Z6JVT8DdcjUXDsK/mul0RTHKswAxNrhv51E50F1kBd
 SEHToevBWCPU32j2femZJBdC+PmeGAngob7oIpB1xI9WPNfNXv/Fxb59l4PaGvbgPQLN
 kXttrGslFsEk8pw9mXjPQ4GwDNBsXwtpZRzkibwQBHj0DPLZot1AzcxKQXLYf0Y9j/gd
 /7DFHZJu6khHge+HFlawOeNc7FPhK9gYOdG1eC4FIgnmNapGS98BEHot0PtYtByF2HN2
 rMJ3Iijr8tb2g13UlkULz7HiMFXFGSrB2eVloZu8nt9JizIZO4h8Iv7ynSJE3wa5gk0H
 lDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778065229; x=1778670029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFiz2Or0WaK7+tKx9mItvJJAajfyKQwS7ufCydXYXAA=;
 b=AeWhDoJWznkYLpef9Gepdvr8twKivmo9lhlFKZY4M3hrB5sY4v5P5rJgGccBjI2kb6
 uu1e8V7XNBVwksSx9D5f9k8BMaYYuwANvWUwnqeYdT4inZ5dntLudcxLOjWINQsLJfPr
 8YrXGyPQtf7+X2nyakGHXjN/uIXCOfV4HnC+qckVTHUkDD4IT2cMMwJfF+T86UoEMviy
 DM9yyBqoejM1AM1TdoW/fKNWqmtTTw4xBHTD6LXcc+Qm1KkXXmfYijnGip+75KleEg5e
 YtGRq3lTjPgxdeLsD31/D9gKOsPiUyyTS7h0HUozOFr7BxAtEF0KiEJkXupiGXAlwQ8I
 VMvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SpR0z0TCKpPGC8nngJeA+OVLr7UiLVGwxQoJSZ7UQf6AYad0Z23m7U4FbwXDU9QNCg9XyWfA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+w1PcRTlBDuAxU5XsiWV3GcrAccMcfGksATbjGacLWPhQc43D
 KxLPJ//Y7xunJNHipB6Oda1dU/1c8IfwfMBeYrCs4fOxdkaPtT8BCuPxGyho0N0ZjvZiB+ruHkV
 sk/2E7u8Ton71kUnM84JGS2WKXWaOOTA=
X-Gm-Gg: AeBDiethPGvKf0GgCIeQObp+hQaxtJI8CDlsV7fXg0ejVsaZehGVL/KzBYmfp0dVUuQ
 NYORayDbbEK7ppx2W1bBydKEYktxsQnumzDwYdCA88yvGBkBpjtNmj/F8qoycj8fP85k110sSOa
 LU+JGVs0a/4UNA8IQ+HLWqZHX5otsC4y47suZF5t+8nk91mT6VVMHs7DqqFReyPDmR5S60Y2llP
 rydmtolyX3UB8AaJ2atJV5ryb6HgOaLTG7f0oFC9pvsuoMCQ8JM31aZ+KQZz4lwztAGnjuMEvFw
 Z0/G0VVCGTp6NcIpoDisqAoya/VJa/gZVJm+PEUXZ6WEC1LjR1s58/vQjm66+owZUIB3pF0NSpw
 WIlrPP6uDBNLvg++Qibu/pxau6ljCyt+wUjrmuiNCFSGTGAeGSNm0yQL6oOubhyMuOTkeTAWUp0
 miLto/mG1c5oQ=
X-Received: by 2002:a05:6402:4251:20b0:674:28d8:11b9 with SMTP id
 4fb4d7f45d1cf-67d63aa078dmr935152a12.4.1778065228966; Wed, 06 May 2026
 04:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260428162319.99B4268B05@verein.lst.de>
 <20260428163922.977E668CFE@verein.lst.de>
In-Reply-To: <20260428163922.977E668CFE@verein.lst.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 6 May 2026 12:00:17 +0100
X-Gm-Features: AVHnY4IibH1x0e5IPjicmDuKOc9NMciQTuqgCZAqW_scXPTRUTam9qh2cay2woQ
Message-ID: <CALeDE9PMVyNjhxKeg+Ok5fvQ+OF7Aopm+Awu3zcEo0=ffM74Fw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] pci: brcmstb: Fix PCIe bus numbers
To: Torsten Duwe <duwe@lst.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, 
 Andrea della Porta <andrea.porta@suse.com>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Stanimir Varbanov <stanimir.varbanov@suse.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, 
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Pedro Falcato <pfalcato@suse.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 28 Apr 2026 at 17:39, Torsten Duwe <duwe@lst.de> wrote:
>
> From: Andrea della Porta <andrea.porta@suse.com>
>
> The linux kernel assigns a new domain for every Root Complex where bus
> numbering starts from 0 for each domain. U-Boot does not have domains
> and uses a flattened bus numbering scheme instead. This means that any
> device or bridge on the second enumerated RC will receive a bus number
> equal to the last assigned one +1. This bus number contributes to the
> address written into the index register, which will select the
> configuration space to be read. Compensate for this contribution by
> subtracting the base bus number.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Tested-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  drivers/pci/pcie_brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
> index f089c48f028..47c0802df23 100644
> --- a/drivers/pci/pcie_brcmstb.c
> +++ b/drivers/pci/pcie_brcmstb.c
> @@ -125,7 +125,7 @@ static int brcm_pcie_config_address(const struct udevice *dev, pci_dev_t bdf,
>                                     uint offset, void **paddress)
>  {
>         struct brcm_pcie *pcie = dev_get_priv(dev);
> -       unsigned int pci_bus = PCI_BUS(bdf);
> +       unsigned int pci_bus = PCI_BUS(bdf) - dev_seq(dev);
>         unsigned int pci_dev = PCI_DEV(bdf);
>         unsigned int pci_func = PCI_FUNC(bdf);
>         int idx;
> --
> 2.54.0
>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144E9CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8345183E76;
	Mon, 11 May 2026 20:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gdkVnoHg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C3E83F14; Mon, 11 May 2026 20:26:57 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1D3383E36
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bccb9dca1beso359085666b.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778524014; cv=none;
 d=google.com; s=arc-20240605;
 b=kR8EfvRzblObgDdyBivFfDOrX24qjCkWxsjK8F/reeQTEmJB2aSnF6n51DG8vAlGYG
 FQ1gjisKv3WtPArTJVFeIh6I440r1gB+UNA3dfDE4rU9tFY7RtXBok+hkF1ukqfjSG6P
 CXwqFjsGc3+wF+59nQ/hRCVormmI62k/I7jn9ahJE8VFllXFY3FtKLxwaVl4w082cxDl
 +SVSYqRyNhsFyyP1ImLjsg4zFjKbw8CZ/CVJddqUKDLPvijVEbdz0yAu7lX5UbxTlM2H
 rwuuq6ghM5+/+H3qriKHpbzHTaQd/0MJdeQSNpamgjn4Zm3nyzsnJhP+918OUVHWAIPS
 sCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xV3UMWzoUWbRTvaKNA3xYcRxnz5sdsrIXQZruSC9lGc=;
 fh=eSkkRHdRZUDrZsck/Aj6hZLJUJE2yZbqZ7CUPuTwlBI=;
 b=RNPpFeStkajjbbtMr6mvreMB2WnTjHiHFMCUM1gX+cp6Ek55LpYxhlg+fK4f991rVQ
 dOUSdpWpWCM+n7StGscnY5HE9PjgUiXx5Niq4t10/6w98CPgDInIl17NBepvMDdrB9P9
 KCKcaCTRag0sM0R/eHmLBXk5S5nVsLV900Le1DcQwWtwJkqb4UrB+tN3rszBNg211b/C
 wlEXdqgBBpK64JKh7LaXEOkFq+Y1Ls+aXTVSsVW0v1q3EBrajJfBXbvBxap8svZDY4E0
 jLLB2SRwWtgK37L3SBQfEbWGTMHHKmgUguxbMT76jt6kifhsHcTxh0P4b9U0sbITKF1u
 Yi0A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778524014; x=1779128814; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xV3UMWzoUWbRTvaKNA3xYcRxnz5sdsrIXQZruSC9lGc=;
 b=gdkVnoHgVLV18mKa00qSi1YRSKnO9RtiW81z9MbrN0ZsKyWxhNyL3rbRI6T+VBHqfl
 np3DZiMNLiS00XUgu47s/zjUWo5hlToilxSQmH14yLhcM88x3spIMMf+Tw57oXuQzPgp
 Cu6TfZdQ2xZolofqVztX4M6EptRqw9k50P5wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778524014; x=1779128814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xV3UMWzoUWbRTvaKNA3xYcRxnz5sdsrIXQZruSC9lGc=;
 b=VQiqUU+iYjdmFqThLGelEgGPC4Tu0pCso631h9sPuQsyziwDmckopiX/GfdWdqEk9Q
 jE9Vn1QEi7AOXn0pae4yYWDj7ypfj7RlSCe4YLGP6F0K11bpTN3dD+BVFoAEPyQPqQYa
 nIpKq3lKvNk5QOFQftzimCprZzET82oCMuC6kwdHxJMehEScE+uwlKUtocY2Pyb+sCfY
 67Rq2FRXt9Yft7E3tKlNV4eLPK2FUjR4TIwm6/ilqV/G1tQttal9IkHwEFvk32OR4M7j
 eAtE81dHpdTaMY2E0lc2TBM50GDO0JQRHWbUn/3Nyzlshoq1QCLeuWVYDyBDQqDKpA/z
 NtZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ90RUHQhQ42sAMZJpsOSDekJwkPamj4NVI2K0IubOIQQf3Ap0yRqM20ZsrcjNWKU3ffckd5RC8=@lists.denx.de
X-Gm-Message-State: AOJu0YzIfAUpaGlDwxDdLdId3fKLjaw30xWGuRQsHpJHOrS81cy5BdE+
 CYvt4As+EVyGDWP2VPWlOaq0dVLr+CB3w5K7QzXFIHT+uyJaqpS0TRO+m+dCKv1jVPOAmipIm11
 OhmOJ3LG9+v0fdufswgJ844kNECb8JN6FbOdhVpsW
X-Gm-Gg: Acq92OEWac1Cb/4doWsC7mn+maSMxH93uFLnuKH/iG7GBnAtWfvzUKR7F8TmWwgjIbX
 la3CeymWUpcJvch6SVZJq7Cf5BE9VJNS86mUNdoDyMMN30f9w0WnyF1CfRWQuEOMX3E8crdXxcH
 jPMCAc8tExwZTpGcEVNucT7Gq9xqk4m7Q3iUAh1utlS7Dnqieij6YssQVd++YAr8skVmGE/S0/R
 Raiu3hlKy1e7CAjNWGotFjRcNq+zF9epUhxVEGWZFOaee412G9qXpHMAva/oN6kVcEiV0MdR+ni
 zNusP5JcU5Xh4nuO
X-Received: by 2002:a17:907:809:b0:bca:48de:5cce with SMTP id
 a640c23a62f3a-bcc1499a53cmr508083866b.36.1778524014099; Mon, 11 May 2026
 11:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260508222911.450165-1-rs@ti.com>
 <20260508222911.450165-2-rs@ti.com>
In-Reply-To: <20260508222911.450165-2-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 12:26:42 -0600
X-Gm-Features: AVHnY4IfXyIWHHWZGofXSiGjVZVlUpsdqJIXbnbYWJbDNZghNWGtLqFMRM97uhE
Message-ID: <CAFLszTgDu56LqCfzXgZ2P=V6szOYytMSvj0LRn4u4S8YWOcEuw@mail.gmail.com>
Subject: Re: [PATCHv6 1/3] sandbox: add board_get_usable_ram_top
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
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

Hi Randolph,

On 2026-05-08T22:29:09, Randolph Sapp <rs@ti.com> wrote:
> sandbox: add board_get_usable_ram_top
>
> Add a board_get_usable_ram_top definition, since currently ram_top is
> equal to ram_size. Attempting to actually map ram_size with map_sysmem
> results in a fault.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
>
> board/sandbox/sandbox.c | 5 +++++
>  1 file changed, 5 insertions(+)

> diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
> @@ -105,6 +105,11 @@ int dram_init(void)
> +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +     return gd->ram_size - 1;
> +}
> +

Please describe which caller actually faults on map_sysmem(), since
that is the real motivation.

But this contradicts the documented API. From include/init.h:

   The returned address is exclusive (i.e. 1 byte above the
   last usable address).

See the weak function in common/board_f.c

If the real problem is callers doing map_sysmem(ram_top, ...) and
faulting, you could fix it in those callers (use ram_top - 1 when you
need the last valid byte). But I could take a look if you point to the
code.

Also, this uses gd->ram_size as if it were an address; it should
really be gd->ram_base + gd->ram_size. It happens to work because
sandbox's ram_base is 0, but it reads as a type confusion.

Regards,
Simon

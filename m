Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEDEE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 14:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD3F8021A;
	Fri, 20 Dec 2024 15:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="cQgsvrrP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E94680077; Fri, 20 Dec 2024 15:44:07 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A7468007D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 15:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ldevulder@suse.com
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso19357045e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 06:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734705843; x=1735310643; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rHec8HmnP2t76I/XgCFbjZkJ762ywHZYJMOan/X/Xcw=;
 b=cQgsvrrPjRNJNVqMnXsjFQkRnaTGO2Chtg0cQlNLF+EJcJ6fnA2S1L9GjMOTRNcPS3
 OOoT4TYYzVVXxPu490ew65D6mr8iT4XONr8lbwy06FzgkZbUgmz6R58pk50kbX9Fy+Em
 WSiYFNsQ7xu37iUhuZkvMD/n+194LPqjxo6cvdDf7Qw0rw0sW8Nljtl2Zor7SOqGCe++
 ht75lf78vZ2IOjGtmnERrh3XIpIA4BWxTqo1yl9cKwy6JT9CWHSpjskD7HThLTd/WwHu
 5tzROiXPJeHa5peXC0jDn9j48B17xRJNLipUv4iuJBU8xuTrxxU3+MMByhQkP18FL2Ug
 OgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705843; x=1735310643;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rHec8HmnP2t76I/XgCFbjZkJ762ywHZYJMOan/X/Xcw=;
 b=BGYfZoCjkdrfZBwNUTVewU6rOnSIKOpFPz6/MSigEex606vo9ilw3jmz3AzuX8K3n1
 8naDQXp43ohCst6HEG91pj2wRLqDhl59NIib8gQQmAYEMXtjOBXGSTzHFj1zvb56dttG
 4F2fTcze2dwRYvYMYBCezAdk9PNZ/EmDDTF+/jf6dnM+xZpELJ7XwQcH5Hbfm4IIwEvU
 HXptFOuDwVjnBuyglE+Mg00nMEOCcuRiUj5UZxDlH8S8OWrA9a9MkGNJN9VdH5KivdL8
 634pdJsCEphMAFAEtoWZzxP7yMjZXoTzgYxwck0Zp97XmwWgJFp7vpR4+xfLdWqELOXw
 +k0Q==
X-Gm-Message-State: AOJu0YzRt6qUVfv3OoHaAk+BpjEReXAfDH1/HSGIG2fLnOME3jDYmKEB
 ncmsniWG0bn43X2rUwgjDEL/oYA46lr/MYXmEs3JFi8WR1n2dLXLcp6RdOb6Jps=
X-Gm-Gg: ASbGncuXiIiqiaVuNrJvLfbbd94DnCMlXGH88gm6GLMlyqiANWtVGHMr5EMZniJLrNo
 8LPn5XXgX7nxCV9SeT5cve8YL7DDg+eJQILUxcMHixKUaw1/LGQwwfPS+JzcLgz1D6kphj0+w9m
 1O87ALD+JQPuIJbTcqHbKBkcTr4QjooKKM9Va0gFPPjPfJ5SjRi4O5Yd6icAidHpdzCmNYIJ6cK
 CilDPLd6CsnjNy2/B46azGpa0ejeviHMW4s8nuuD9OR2hmtJ/wozm8=
X-Google-Smtp-Source: AGHT+IGfktk5x7Y0OCOfkyvMb4SUIxhVR7wREm3poShla/tlTUSjJKVUrLfij4ZTzxn4D123LC/KxA==
X-Received: by 2002:a05:6000:1f8c:b0:385:f89a:402e with SMTP id
 ffacd0b85a97d-38a221f65c9mr3594158f8f.14.1734705842985; 
 Fri, 20 Dec 2024 06:44:02 -0800 (PST)
Received: from [192.168.4.7] ([82.66.145.28]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e219sm4252351f8f.84.2024.12.20.06.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:44:02 -0800 (PST)
Message-ID: <da88bc449866a7d78c935e40c9a77fe1eca2919a.camel@suse.com>
Subject: Re: [PATCH 1/1] configs: visionfive2: enable CONFIG_DISTRO_DEFAULTS
From: Loic Devulder <ldevulder@suse.com>
To: E Shattow <lucent@gmail.com>
Cc: u-boot@lists.denx.de
Date: Fri, 20 Dec 2024 15:44:02 +0100
In-Reply-To: <CANV2PTPnutTi6nZ2Nq3UvuZbPr4pedB1vo6ZWtQj4+Cif3diYw@mail.gmail.com>
References: <20241125093908.50903-1-ldevulder@suse.com>
 <20241125093908.50903-2-ldevulder@suse.com>
 <CANV2PTPnutTi6nZ2Nq3UvuZbPr4pedB1vo6ZWtQj4+Cif3diYw@mail.gmail.com>
Autocrypt: addr=ldevulder@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
MIME-Version: 1.0
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

Sorry for the late reply but I didn't had enough spare time to test before.

On Mon, 2024-11-25 at 02:40 -0800, E Shattow wrote:
> Hi Loic,
>=20
>=20
> NAK.
>=20
> This was removed March 2024 already. See "board: starfive vf2: switch
> to standard boot and fix DTS"
>=20
> https://lore.kernel.org/u-boot/20240221120014.149193-1-namcao@linutronix.=
de/
>=20
> Please divert your attention to review and test Hal's patch series:
> "Support OF_UPSTREAM for StarFive JH7110"
>=20
> https://lore.kernel.org/u-boot/20241125003205.75327-1-hal.feng@starfivete=
ch.com/

I finally was able to test the v8 version of the patches and I can confirm =
that it works as I
expected with latest version of openSUSE Tumbleweed. I will add a tested-by=
 flag on the series.

>=20
> Thanks,
>=20
> -E

--=20
Loic

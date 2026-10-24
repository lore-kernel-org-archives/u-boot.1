Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC6606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E6byKTVB;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kmp716fj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6630981919;
	Sat, 24 Oct 2026 13:04:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W2eh3DzTWFap; Sat, 24 Oct 2026 13:04:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 103D98195D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847044;
	b=k373g2IIwdb9pBoaUaKbzkaN6O7EcKOVI8O98fqUWzizrt0Vy8b/URRsLfBNIwB3wb03
	 Ns8aY9j7eIaTllyWV8lGHT5RgA2ObY0HkzqWy64mCOpL8yFG8OKcuX5clqjyo4z8HPyT3
	 OYgOlxGl54U6NNs5vfdfCXt7ZhLISkBjWUVjsAhh5FAArdY7+m3kTRx5n/FV2MD/al68c
	 V94DXj2gthKZo4uEZCsVawOjoW0o50YVmRvEOZATLt336v85UIJDfpLpySxy352LzBka5
	 qCRPLWbBzCQwgwIWFo3tw0I4XwF2Ghj7jj1X40fXLpiaU8v+va8VlGD2puj8eHkE8HA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847044;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=thjvcm7XEy3zDMDWqMIMhHARKJNN521c7JsuusmeYcE=;
	b=jPtWFfw3MBkLr6JpIArpzeH5h+m8JIcMhxAwNkYe9yvvBFasDux3reeaz2i6vTcz4kpT
	 eaOAUMAgVA8a1ftrR2p2oYrhgbquGKOoQiW4uAKjeFkfDJmywJCbr3Nd6Jwww0wlpMP/w
	 qFMPWrMbw+UWU9Pm0+Ku3T1iEKo6CyKeCcu4MdQ/4QqV0BCDgLAuMXZMvO9GtgOR0DsTJ
	 I/3WiBVued2Baad4tJPFD13sMDgCIfVXhyw3KAEkeXUzKr2Stc9GXZZ3/3mTLFsPzD7Ak
	 C3XPiN1KUzdTlAMiqFP0tk8bUPTkOaAcjS5yJOOJpclcbalK8yX2ZgwL3iOfwVEccAw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kmp716fj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847044;
	bh=thjvcm7XEy3zDMDWqMIMhHARKJNN521c7JsuusmeYcE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E6byKTVBgyZYPFqxoSQ2cwG/OjLoZIuinZdvZ12PACSKefws/l+ifE2jCAPmcC44C
	 ZVwzmWRW5tleOBoni2ja2TxLDu9RqARJ62CUZ2Kc/2OeDxWgQBq//bG68Fgpr7WfHq
	 4UmyvBOdvlaQA3eBxzfLlhWPm1M0FvmP0lS8Yo7CWhBFvsHpW9iKeLtl7TK3iSmvCf
	 eCMpbFJhica+fw0FVy9pfI4kKS9h+3prwXGoohaDUwLJQSeD9BlLgCGVd4ZnLPnWNj
	 z/maT0IssZ87vBShPjukeYFUXXnvW8aZvtlZwqmpUVqvgrb6QDfz/kZ91VB8vl7wpp
	 aO5Rpo0L9U9JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 103D98195D;
	Sat, 24 Oct 2026 13:04:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 35B07235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B8498162E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 92VK6bcMPGuj for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:01:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1676E80D35
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825305;
 b=RiX2nwxHtxmty/6u4nia18txObB2E/E8amCn6FgVkyS15k5fwY8RJzTV2nft5q4pffzO
 gFGZUTiS1QPOR5MFfMuDGTyOYl3HoOC5AWMvn2A33pjcQOfOAVnG8aXvrDiF31buE4Cc9
 sHOCX5JujozuZcm+0w2FUlDDeejBt4uR4P4wgn3feRNpfWkFJ723QM5rhjBlCIpvsToDj
 A46iQqT46e38OFI7sBN9OALGMPLgTaPN/sb7HnfxMdv8EHsOiXMwc9gUDjIJbcmaa/gfw
 yOPbywsoUwM1rioRfiqBx3il81X87xSKtH5uPNn6X3STqF+3ehNbu7GwgITNld5qiiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825305;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=thjvcm7XEy3zDMDWqMIMhHARKJNN521c7JsuusmeYcE=;
 b=rl8sOy0J4F+Yi48PkTsUO1ZwUFLM+/M9DwPAAc4eFOALouBgrD3ip1RuQsnAnFFB8lub
 yR88xQH8qYmra5LWGyILc9uo22KZkcwpeFMgS9SpuF/pB5w0Lq57j+oqimiwcari9avq3
 Vvx5hFIKs7XczNL1fo60ikoHyg107DhYrn8qi1oU9hC7cfM0yM48WDaIBqMXG0zC4vpd7
 8gYR05IxUmNzOCOpt2ac1tBVFoPBpbTZmwFO2Ft8XAnb9Gsf7J24EaB3JFjPJC/BPuHjI
 HLu7DGhA0PWrwb/Rkcu9E/KuIkNZXwRErgLAfXx/zWvHA1UGFVdS7EhpQ2i7cFh4W9w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kmp716fj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=kmp716fj
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1676E80D35
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:01:44 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so2622136a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825303; cv=none;
 d=google.com; s=arc-20260327;
 b=Da4AN1f1CZQR1MzPe1sCsgOqeH1iSqlLx+Xas4Oqo3WquEC2WbNZ7upTQFf5Qi7PXU
 aAJZ1+D/0yn0Y5xX4Cr9IGhUZf4nEpanyq+risr8BGBAhrqw1pwwr91n/fgFqktiugzR
 XBuFsEhiww2yfbja8zHWXnGN47KxFYAiO0quR+sUY/4wNJFVM2POe5Hs2TjexoVicEYm
 9Fd6XEjD7NZfNzA6VJOJf+2BWLaSJ+Y7qcg4ISYmilUzroMHH5i4jOWIKkFqX9ixznR2
 WAk4qPygxhTpgxXRy5s1nnQafHHgMgiQCWM+461zELAP2RnTrlpeFcHFdmmCt2Ny2dks
 LseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=thjvcm7XEy3zDMDWqMIMhHARKJNN521c7JsuusmeYcE=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=I+RwHfJZsdAKTu+dSe3kP/YdnwGgR+Ty3PM/vfrDlaDtS6hMiwZ/BwFNhgkQX7thFA
 09Ma/C9AZbjPNtC4yxL4vnKLycDJoGJlpj68XaHLqcDCoXvwg8gWiymNw2pNNJMj/7K1
 hIob5edNHizSFIWu1/udoqRz92umBn6xRunxdxH+CcGgriPoFML+0z8/8gLzXJ11kzs0
 kaCAVbpRwwNapixowyjqUUV9QVRA3kwt6G39BpjLo9xknu0Cnzr1Ly6Hei38Gtb4Ka/D
 lCQv9WuH37Goi/FhrTutSW/AoWjcYafQotGePCLbc7Uoo0SKIesUFFkzzGaUj6S+7PIm
 xD/g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825303; x=1793430103;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=thjvcm7XEy3zDMDWqMIMhHARKJNN521c7JsuusmeYcE=;
 b=kmp716fjw1vtMo6y2JhSln1V3aEwCqtkMr98whxw0spj1zhfHn4Ne2f+qMyjDQ88R8
 4vKDm3LRN7U02qSSe1Mvln/ZcHrErmlXpJU9oklFSbBh99wSg7tQKq7YsiIyNmEJXuce
 jYnKDNNlWhz6mPmDdSRLmUG6BgEsmPXUi0oE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825303; x=1793430103;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=thjvcm7XEy3zDMDWqMIMhHARKJNN521c7JsuusmeYcE=;
 b=bO7uIxMgsv7+xN5KqXCzg9CSnrKdpzuWG/mhazLuLrGgb9Z+YF5S/R+8D6AEZfwwKd
 uqYLz8Buhbx7QwDmP8Ru9VgQar7PBUfRY7rXeX8zTXk4GPtx79t4wLdz09hUBejLF63m
 hPeZpQZw3ZrW+Rhbw73M2MtnSYR+ij9RIiVtxsJQVKJQ0/q9RREEYSKoWvH1VlX25lFu
 w4hTY+VgmATFE72du0biwp1RLgDA+GmaML89fD0nDxpnYZ5wP0tLNIqCW4YNFFXFThmT
 q9bJU2lLp8tGW6+IPBjGTUQaU9JBFr6rhn3+4cZ6nv3Pslx+pH2Nb0SL/x4O6wH0Wo/O
 9efw==
X-Gm-Message-State: AFq9FYJRpn9v4MftZ0crCusbLeOK3BzGoVwswj1iDJmcQ4besP7U2117
 5SlLjQWWC50cablivbtmNoPnxkoTtHyW66GdE2nrJjPX5EGH9UUp02iNb6LcJBT5Z7c6wKoXvFa
 waBDBOkJx1wGOe0muhYhT450HBedQrlDocFvuOnny
X-Gm-Gg: AYBFou1IYnlG5IbMXQNgxrDwTm0KREiIvnXceC5Cf+mWSHD6nyyckK9VG0dESyKUjnP
 NwzJGYvlinwnZz7sw/x+7gOCODvAY7b7NGNmx72akIM2t69+zCXl1VmKBaCBvoZgtjqDrtm9Zq6
 JzD6tK9xW3guE3yc3owWuX/MBh+5ioBFbJ1JeXq632Jv0oK4h9V4KXk0ZSyiMAfAVslEHnrnE/g
 YIHCscbiJJKoUMHe51Q+7YtcdMw3GCx+7ptWe8ou6EM+HNyIYwFObX7WhGBdqBbtL/+ZFbNRuAO
 9Mb6JuTlsdwYyAGrqeDV6FD4yGC7pbth+Vs19voRrQMxKp2O6RLiv1ZNqnAIEdGc58ytGq0i6J2
 9T7GSkIbEnwAaEp+MHePlMuflICWU3Acz81I=
X-Received: by 2002:a05:6402:a514:10b0:6b1:eeca:87c1 with SMTP id
 4fb4d7f45d1cf-6b442fd940cmr1008407a12.21.1792825302803; Sat, 24 Oct 2026
 00:01:42 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:01:41 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 12:16:26 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-7-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-7-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:01:41 -0700
X-Gm-Features: AclHuK9GS47RdjkhL3wtg6bPgyaaF_kCvstRjRig4LY2bRmdeuiIXh1TAt0lg10
Message-ID: <CAFLszTgx7TcmbEdzTkZrUr=7N5RsaKGSBkBSVVfJD2VKYnrhaw@mail.gmail.com>
Subject: Re: [PATCH v3 07/23] spl: fit: Decompress any supported algorithm
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> spl: fit: Decompress any supported algorithm
>
> load_simple_fit() open-codes gzip and lzma in two places, so a FIT built
> with any of the other algorithms image_decomp() implements for SPL (lzo,
> lz4 or zstd) is silently copied to its load address without decompression
> and jumped into, causing a hang with nothing on the console to aid
> debugging.
>
> Call image_decomp() instead, which can handle all compression algorithms
> enabled in the config, and will abort on an unknown one instead of trying
> to silently jump into it. Bound its output by the max_size the caller
> passes rather than by SYS_BOOTM_LEN, so that a compressed overlay can no
> longer run past the end of its buffer.
>
> Read the compression regardless of whether the phase has a decompressor,
> so that an unsupported compressed image can fail loudly instead of having
> SPL jump straight into its compressed data and hang. With no decompression
> support enabled for the phase, a short-circuit path is taken to avoid
> linking image_decomp() and the table of algorithms (up to 1.2KB total).
>
> [...]
>
>  common/spl/spl_fit.c | 78 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 48 insertions(+), 30 deletions(-)

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -325,10 +358,8 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
> -	if (CONFIG_IS_ENABLED(DECOMPRESSION)) {
> -		image_comp = spl_fit_image_get_comp(fit, node);
> -		debug("%s ", genimg_get_comp_name(image_comp));
> -	}
> +	image_comp = spl_fit_image_get_comp(fit, node);
> +	debug("%s ", genimg_get_comp_name(image_comp));

Where the phase has no decompressor, a compressed image is still
staged at CONFIG_SYS_LOAD_ADDR, read in full and hashed (with
FIT_SIGNATURE) before spl_fit_decompress() refuses it. This also uses
SYS_LOAD_ADDR on boards which never needed it before. It would be
worth returning -ENOSYS right here instead, i.e. if 'image_comp !=
IH_COMP_NONE && !CONFIG_IS_ENABLED(DECOMPRESSION)', so the error comes
before anything is read. The check in spl_fit_decompress() could then
go, so code size should be about the same. What do you think?

Regards,
Simon

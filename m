Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6588FCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 17:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E14EC83B4A;
	Thu, 27 Nov 2025 18:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SYqaFIV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1900842A2; Thu, 27 Nov 2025 18:25:26 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 744FE83B48
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 18:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-37b996f6b28so11666551fa.3
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 09:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764264324; x=1764869124; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEJYs1kjazVpX0S0cAdftdtxqMvIU/EYZ8YOPqDHobA=;
 b=SYqaFIV/gzbpKm+nJFNcWGRUIv4gBEaoyHhyE3zpoPSktWcgNd+0XYq5g3k+uDUZ5N
 bbAPBtoR8tKm/wMLREwS0uYgmrNhxG1fxafQl8BpojL9Dcf+E5DmlSHG70WH+2eYWAqu
 s1yFvh6AB+cxw2HQ/YXNchfoY0svf4X2f3kSngfkPbSLQigim6pQyliQpBOR62aM3tQJ
 0lh20fQp3Edtor2D5b4KTNI3UdN7LDUixK/sjTDejRqC3NY8EHh6P5UtXWQDtcEezUzG
 dVRHs9g9MbhEUJh59vqxH05lAWJrFfkqnGvTxUjzldZ7/unf9gVovGG6eW/s7OA3zBJC
 ulZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764264324; x=1764869124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PEJYs1kjazVpX0S0cAdftdtxqMvIU/EYZ8YOPqDHobA=;
 b=XH3nW6irckdDZ+51j4dnwWbn3T8Hru7cBocIbDLzD8XDnHYTIabTv4pRnj3Du7ARWN
 DfIoS0kJ1iAjHEQK1uPuvoc3YsylB1clZf79qh6SteK+wPuIvy23Z+WSRnGm8/4ZzG55
 6PxXb8257dZc/FRi12fIbodRobNHpevH8P+T2YxYF40lDpd+fy41lsf6zbSEii4Z78Io
 T4PwanReVfZn7NqVMvkZ+gEyrSzEnyp0TiBugY8SSgymG6N1r0Rwwvt5hpbrgG2Os9PJ
 9jBcXpfHGgptTIDKp1OdH+/zIvaYbIyjJwHpNsMVtBv6yfYyHotSCZoSkS1Xkg3DbEky
 dX5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpc7CCq57ZGVvUUv9IBED05/8xatQ5NnYCZrswh5ct601RZ/PgeXHxi6t8idr5V7Sab++NwUw=@lists.denx.de
X-Gm-Message-State: AOJu0YyXSDUBvKBkGnCLLSNfyWN0hY25wFACtCRYE3jM++KvbJaqKKdr
 DvNZ0LiPDjb1pfkXbMLup4oPNNVr7OA6LPUQAR2r9cQ6Sa789SV1XfqZ6vVhhOXKMUClK249nLl
 oPK9u190IN/JgBcAYmGhLPpCsrI7ag/k=
X-Gm-Gg: ASbGncvWqK33fJJm4Nts+A0whm8+GEOuuM4SfyZorE5w9o5oA17yt0eF/hzrjTJazhk
 kudQsZr2Wrj+WBEt3x8Q+OYwc3yENNhhvMCBLqIREToOf5JaqWChOnWdj6RD1DMa5OQ9vtaOS1w
 BM8b8y9S4wlwqeh/IMzA88flJnnMwGP+NdghABfc2WGfW+WVCfHT3NcBZORvh60u2POSWtgPao4
 HKIM/UwAAItkMpa4+NfmDdXqOxjchkRAFhzu/zbqXCCHmIXtFqWSvnDn6wh/DIokvpMRn+kauDZ
 e61S/CU6zylhj/o8ZIjPSJL89Vs=
X-Google-Smtp-Source: AGHT+IEAC8vmNqElBGPff38LuTbnAeHyHHnK64uO1gNt0ZGr1ecn06J6DC8kNSQAN7NFvmZ6D0+qbR81CX5rSnU6zwM=
X-Received: by 2002:a2e:9215:0:b0:378:ea85:7f06 with SMTP id
 38308e7fff4ca-37cd92843f4mr57797171fa.36.1764264323320; Thu, 27 Nov 2025
 09:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20251126134107.2969608-1-max.oss.09@gmail.com>
 <20251126140340.GA45401@francesco-nb>
In-Reply-To: <20251126140340.GA45401@francesco-nb>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Nov 2025 14:25:11 -0300
X-Gm-Features: AWmQ_bnK5PpjJSInzeMqsTYoDayfRvuqj0tUT3WfUgB4GWwJ8SKgCDJr3ecveAE
Message-ID: <CAOMZO5Bs_xx2YmHADF9a2sSxKA3eqHaOYVcK1LcaDn77OCNTMw@mail.gmail.com>
Subject: Re: [PATCH] configs: toradex-smarc-imx95: set spl_stack
To: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>
Cc: max.oss.09@gmail.com, u-boot@lists.denx.de, 
 Max Krummenacher <max.krummenacher@toradex.com>, Alice Guo <alice.guo@nxp.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

On Wed, Nov 26, 2025 at 11:03=E2=80=AFAM Francesco Dolcini <francesco@dolci=
ni.it> wrote:
>
> On Wed, Nov 26, 2025 at 02:41:04PM +0100, max.oss.09@gmail.com wrote:
> > From: Max Krummenacher <max.krummenacher@toradex.com>
> >
> > The SPL_STACK config option now depends on having SPL_HAVE_INIT_STACK
> > defined. This made savedefconfig dropping SPL_STACK when sending the
> > initial configuration.
> > Note that SPL/U-Boot are able to boot linux from mass storage with
> > SPL_STACK not set but other use cases might run out of stack or
> > overlap with other RAM use.
> >
> > Compare with:
> > commit d6a53f523afe ("spl: Add an SPL_HAVE_INIT_STACK option")
> > commit 25fefa05d732 ("configs: Resync with savedefconfig")
> >
> > Fixes: ff0540fcfe49 ("board: toradex: add Toradex SMARC iMX95")
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
>
> Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Feel free to pick up this one directly to master.

Currently, I don't have any outstanding patches for master in my queue.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

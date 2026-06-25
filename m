Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC571CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 725108497A;
	Thu, 25 Jun 2026 17:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a3ITis1H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B889484981; Thu, 25 Jun 2026 17:28:48 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3109A8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c0c41ff84a6so576326366b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782401325; cv=none;
 d=google.com; s=arc-20260327;
 b=L/Fc9F8Ao6PjptkAk5tSYZCKjS4twyGHRDZextty30rQl1W5LFtSBicOUF7eANmQxD
 HKkqWxSOJpLWjkNEbCwThcTy96Ei1Ag5IQtPeOIOun8wrZWv9jTYHmUR8a1lBJgvLnGt
 yZWZ4gAtQlTJd9hcRdkXObytbBge4RvUk86t3HAnQJZQH/DmSlurvR2S4la3r6wLeBuo
 RG2khCuGKNXVXeMFoswaPYUbRQfUuGwjrpTRRUCfT0TP65OsVsF2i42RoKMjpCEpDL5u
 hbVdyX5Qhow+8vR/s/oJIfyJ0RA71zGww/AkRan2QB+b265x4yzQKy/+FNzV42IwhOiU
 MjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VQ9dgwbYZJw4fFyBOM0xvtbUufyUh07UALfvaMwdFWg=;
 fh=pqQDfe3LJMDmm+c9NDum1Jzf1ll4C62eeHhIID4fPOY=;
 b=gUFeh9vEXXDiXQ+lYqTBPWhLJhs0/Spt5s32C2yI5SlEHTU6ZeqOWz2DqaJWVmDN0X
 kabxXQUqjhQnU81sTyDssWMvm8TkLEzwAOedRKrGr2XLFPQM41luf7E7DJDDqyEnjXEl
 haRzPfmtmZD0pFYRHiL9iwiLGJpqHLXNz/1PlzFzh3A4hrNZsBWQnJKGkyXtQbxxAFdd
 iJfCCN8gSwCM4eHbrmH3h8pxGG6zUrvw8NTmHDWIPVEk0Cv1HR14qGriZLGhHv3dA/u7
 +ZmMX2/RWXweTSXhkMU9ZmVT5skHEyH5HcTWCdQHGim6nToomIjIHAjQ3cgwSc3/LnNM
 puVQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782401325; x=1783006125; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VQ9dgwbYZJw4fFyBOM0xvtbUufyUh07UALfvaMwdFWg=;
 b=a3ITis1HPXceNuIAsv+G5EeigGBBsZ5IGT4obQ6/hKK4t0Ohblde7hWbCNpgWjnzh+
 SvWrKxqNuLJli/zTjWU7Xi1QqXlEY0IGUWnSzysUAzCXLwhsTHMuMNCXiPYiElJW/Avl
 gyWvDBTY/RpjeEm+nlwv6qhWBveZX8VqkD8Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401325; x=1783006125;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQ9dgwbYZJw4fFyBOM0xvtbUufyUh07UALfvaMwdFWg=;
 b=QnQAPd3TcCTGJc9EhU5diqvtLM5DM2SXCWuTFjhBO8cQqZ4pGXTmaMCF7xqqfbkQMc
 zW3gWVHSv3MVoRLu85uGC7OFl4B0zDGHCmnbowfyRYqasDysJq/np2APuiUWDSe0rzut
 NVteyrYi/WSLmiD8NB63WhxwOEIJfYs8XhP484v10vDRxgEm6UMDsLaDo+o1EDOauPwq
 dLriaTxFMgxWcktuBtKN0njO+JICwiW+R0c8K1rhDSnA6s7uvfqCvP+8mJFFPeRXj/A/
 xTBFpu+hcl3gzdXvUpAN9nAxDqiQmB4JoiP1T4VGR8wZr4DWDJV0aULGP3yQ+C7JaSRp
 bjwA==
X-Gm-Message-State: AOJu0Yw5ob1av5egrZ7czLoAY7dgqqF9w3U/NeLynGLr573RTBf4NBcU
 wduzI91yZ42Q0el5xu/vnXBCtjkNhlLgedZ/0cva26sDrIE1XCZUBZRAeEnVpTa+zitDOGhJ6/O
 sy0LE8CXEA0AFDMS9To2iu6mGPCpIhf3R4As9NXR3
X-Gm-Gg: AfdE7cliLwWgJ/l8Lk5W/1fqp8/CNisISbVdfhXyfJnBVEyfhOLTm4fnQc1ufvqiJoM
 Gc1qz+4hUypWHC1yhomlbOYo7FizTsgWgTD02IvhBwM9+RjLpj1RImdnqk5r6VpzBAf+uTYdC5N
 NHBZhizD99RGg6buYezmEV+K3RtCRaZwHpGwAFXxNspWJ4dfBV4vfgqngU0AlBjasPFYyHzc5W1
 GUbOfU0cVMeLdnFlzmXyOffT41k4kWF2FUxnqfBXrg+TzCxX9kDTg7UAEyEkAmcr7lrsITiXg==
X-Received: by 2002:a17:907:7291:b0:c0f:cd09:2260 with SMTP id
 a640c23a62f3a-c1205f4a0eemr265730366b.52.1782401325324; Thu, 25 Jun 2026
 08:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-3-4ce6d1ee4711@flipper.net>
In-Reply-To: <20260604-bls-v1-3-4ce6d1ee4711@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 16:28:32 +0100
X-Gm-Features: AVVi8CeEtaY3l-pcpwD1c07yP1XBcq2Sjn2t2lE7BhTLlChqSqoSZYzqsgdxDd0
Message-ID: <CAFLszThDsSJSUbKsG1KfNFZzWwzeWUY=XPc47C9CpBZUwEqXww@mail.gmail.com>
Subject: Re: [PATCH 3/7] pxe_utils: extract per-entry key parsing into
 parse_label_keys()
To: alchark@flipper.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

Hi Alexey,

On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net> wrote:
> pxe_utils: extract per-entry key parsing into parse_label_keys()
>
> Split the body of parse_label() into a standalone parse_label_keys()
> helper that walks key/value lines and populates a pre-existing
> struct pxe_label. parse_label() becomes a thin wrapper that creates
> the label, reads its name, attaches it to the menu, and delegates.
>
> This is a pure refactor: the new helper contains the original loop
> verbatim, with the local variable declarations moved to its scope.
> No call sites or behaviour change.
>
> A subsequent change will export this helper so callers parsing
> formats that lack a 'label' header (notably Boot Loader Specification
> type #2 entries) can populate a label directly from a file body
> without duplicating the parser.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> boot/pxe_utils.c | 58 ++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 37 insertions(+), 21 deletions(-)

> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> A subsequent change will export this helper so callers parsing
> formats that lack a 'label' header (notably Boot Loader Specification
> type #2 entries) can populate a label directly from a file body
> without duplicating the parser.

This should be type #1, not type #2. The cover letter and patch 7 both
make clear that BLS type #2 are EFI binaries (out of scope), and the
new bootmeth parses BLS type #1 .conf entry files.

> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> @@ -1288,34 +1288,20 @@ static int parse_label_kernel(char **c, struct pxe_label *label)
> +static int parse_label_keys(char **c, struct pxe_menu *cfg,
> +                         struct pxe_label *label)

Please can you add a kernel-doc style comment, since patch 4 promotes
this to a public symbol. The file uses /** ... */ for the exported
helpers added in patch 2.

Regards,
Simon

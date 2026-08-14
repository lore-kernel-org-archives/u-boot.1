Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900F9C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 21:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30017811F1;
	Fri, 14 Aug 2026 21:24:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X9aGMEdKS0Oa; Fri, 14 Aug 2026 21:24:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF21180F5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786742640;
	bh=zK2AUO+h0QJ6JHv5PhrMaJmHbcGEdbhvN24PQREe5Fk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hvpr2C70lSqOeW/Ouyt0cp7399eBXaKCv4GawcTXPaob12/x4PzLd1mY1F2j7Qy8E
	 VI3PFK9hLQkWybs4pLmEEP4bLwpI0Jtvsyxw3cDx6u4jsOQbLWerp5Q8dILkaXLPYZ
	 V70KUvpPSpSKbivgyVHaxXkseWEDngHJQqI91qpcRWDy1P9xwKHYNml5B/Sdb8BjIE
	 5vkpgE73N1C0Fq2OtcJCgkIf/sAStd4rgXuQglNCZNAg8xCRam/A5FVgAknQybJTy2
	 OabaKp3OAav3j5TwvxXvw6mrVSOEqY25Lsukp1gNddrPI7+ja/0psjf86zRNgp+4Vo
	 8nXiEwXnMsU6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF21180F5D;
	Fri, 14 Aug 2026 21:24:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A6CA194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C72840A0E
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:23:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bo-vqX2Gry2K for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 21:23:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6325540A0B
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6325540A0B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=jfP92geX
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6325540A0B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:23:58 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a386a34603so3022840a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786742636; cv=none;
 d=google.com; s=arc-20260327;
 b=pMPmkt8RSfRXlp+Rz4FSso23W92BbFdLOgWHiAStZgxvWWjFcdxcLW2I6Lif9mFUC+
 nPCmdrBkPRZEG8Uq5BBZ5I1QZcAmRg9u+maH7kN990ff2Hz7LsUKHoiZ4rNAo5Z4/oRo
 eiZ+ShuIjPELye67mWm+n9scYXxlPE3acX02u6b3LkyUnTBpQmeHIBDDwM1m9dpB5U50
 LXbkFzACEYj6/u2xxWgUNon5cTav+yzhnlGDbdF4Ru1UWCG6siMJzxi9F6XwUZbB7wgg
 N/NHOCBR6Mj4xuEqVt7ajy/RDM8OEGdKhO+yNPS9HArcACkSIl11zPOHCQTkifUXC3/t
 Cdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zK2AUO+h0QJ6JHv5PhrMaJmHbcGEdbhvN24PQREe5Fk=;
 fh=JJAwH8KzXB37Ep9tnwPaemnwUh4TNNjCGdGPFYfvgoo=;
 b=Ew3vLJ9E9wvv9NiGzOyt4pm9nd2JGlPWFnoEh/c8hhlophogeCekXnPZcGjueqciUH
 VtcUa7yYJqFsrKmCZk8i368JYXaXhSA4lmZeLU20W/xBfSwwSu/Gtg1m7wwsguy/mxjd
 /XBJwigFj5k6eZSWejP6+oLyLlZkDzKTz9susJGQ5UYOUM3AOShUT8Bq6R/72J4rDNYO
 47yMJnM4y1rB30Dq07dcKjIBVaBO208UmAnZbx2T1RfSfMRH4MrzxTS8/aseF6guOaRr
 CZAkal9mrNjiEGxQjVh78xC763mGleS0K/xZKQwvi96tweObQPqUaYaanvfBpKajRm3C
 bE7Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786742636; x=1787347436;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zK2AUO+h0QJ6JHv5PhrMaJmHbcGEdbhvN24PQREe5Fk=;
 b=jfP92geXj3+pYGS9JppPIxeq+LXAON9nEt987xCxnWLY/w5ZXkUv9v0FQ9c+6u6VEQ
 Q/BSB7wv4O0LtBqAne8O8Q8qq9i0mnXMEEOjeWlHgrTtWfe90PyRE+tIU3TBnW1CKAht
 9fLpXl9l5qFjjjsSAyW9ier70KmqStnDi0ie4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786742636; x=1787347436;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zK2AUO+h0QJ6JHv5PhrMaJmHbcGEdbhvN24PQREe5Fk=;
 b=GqGzMJX54xBTzbDOfLJxlRq/ihyyQ7YMBeeUKlT+xpwI4ACClMpLJcQJzxgH4TcbxM
 sJkimgATJBfhKM67/Eurh+ZaXIlk2pkkIEVeFW1xX23ofgQ8X7ZNLhodSo8Y2jiSlfib
 yay7BSHNOwdD5hsSaUyE2iceVhqByQ+P1H/JBhobdF5sb907KxZ0Bz0OjwN50dFk7FkC
 1GGtvsxaCdqoC+2aQTN8eef1MRlx+DcmnqXQniaLIP73drs4KO1mcYr1KvoI4C3z5A1p
 HNJ1VOuVPaIfL7X6HHauKQqjDQ4YE+lf5nWHGOjiYFlSkn8V4WCYHacqmIXpyQgHnxND
 p9SA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoY5qOdzbMc6BVLg3NzxseIrLhVlYAntBlmhMubfqx3CWdVXpPxaOqzf0NfQqKHXvC0EAr/4/g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx3ACCnbD5qMAHL60QM+fi6qDaqMUSKLUb+Fd2CWjBqBk1YwVRq
 7qlM3ebnYxzu7m4jT2wH/nDe3E8hU2xk3guYKsYA6XyV3OaG5JHB9S/wmCViJfftJTrWyiAWdok
 FT4ZolkW16tThqF2N2YbODLvsgEf/8kFYAL2PbBWV
X-Gm-Gg: AR+sD12HLkaPe5p7oEFvp/ykd1DR6SAB/G+bAkO8S5Y8j52yB/rT/NcvIStuBvqishc
 LG6ImN+hKuZq16kVYxemZ0ad5Op8JkGDMeSN+TijZSTX/XYHy31IPr3rNBrx3vTrt7wTv873s6r
 Cfvk2FWZcWlT/lDAXfyRfxEqSRMXUyBvCQ8uOInLSdc2rPIaRK/GOHW2fdAXUK9sXbd6H5H1w6C
 Ah3iLNlxuOVzC/Xyw7mzGcO+Btx/VUplz7KWzhYKVUBPUHkqAEuUazpJiKDo0CJU5oYvg4r3faq
 ndcE5z6FS856aG7a6mCNWKgBhZnoWH0QI7GT3FwmN1I=
X-Received: by 2002:a05:6402:5415:b0:6a0:de1e:c4c4 with SMTP id
 4fb4d7f45d1cf-6a38af28b64mr4214300a12.10.1786742636270; Fri, 14 Aug 2026
 14:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
 <20260814-imx93-secureboot-v1-4-0c3c78020d03@bootlin.com>
In-Reply-To: <20260814-imx93-secureboot-v1-4-0c3c78020d03@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 15:23:40 -0600
X-Gm-Features: AUfX_mzuNE1ytOnUzcwTmZWBhZ9x7Gvd-4iJXQDPYhib_4skVwXePt1GziMaQ58
Message-ID: <CAFLszTjJ7ztxWuoTED2G-oECz8NoxPFmhOThTS0ifvrk7ER_Ww@mail.gmail.com>
Subject: Re: [PATCH 4/5] doc: imx: ahab: add i.MX93 secure boot guide
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Denis Mukhin <dmukhin@ford.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Alice Guo <alice.guo@nxp.com>, 
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex.vasut@mailbox.org>, 
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi J=C3=A9r=C3=A9mie,

On 2026-08-14T17:07:09, J=C3=A9r=C3=A9mie Dautheribes
<jeremie.dautheribes@bootlin.com> wrote:
> doc: imx: ahab: add i.MX93 secure boot guide
>
> Add a step-by-step guide describing how to securely boot an i.MX93
> image using AHAB.
>
> This guide is largely based on the following documents:
>   - doc/imx/ahab/guides/mx8ulp_9x_secure_boot.txt, from uboot-imx
>   (lf_v2026.04), originally written by Utkarsh Gupta
>   - doc/imx/habv4/guides/mx8m_spl_secure_boot.txt, from this tree,
>   originally written by Marek Vasut
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> doc/imx/ahab/guides/mx93_secure_boot.txt | 269 ++++++++++++++++++++++++++=
+++++
>  1 file changed, 269 insertions(+)

> +Warning: Please ensure your sample is in OEM Open state, OEM SRK hash
> +has been fused, and you are able to boot a signed image successfully
> +without any SECO events reported. If not, your sample will be

SECO does not exist on i.MX93 - the security subsystem is ELE. This is
a leftover from the mx8ulp_9x guide; please change to 'AHAB events'
(or 'ELE events') to match the earlier ahab_status step.

> +i.MX93 boot image. It is assumed that the reader is familiar with basic
> +AHAB concepts and with the PKI tree generation. Details about AHAB can b=
e
> +found in the introduction_ahab.txt document and in processors Security
> +Reference Manual Document (SRM). The i.MX93 signing procedure is

Minor: 'processors Security Reference Manual Document' reads awkwardly
- please make it 'the processor Security Reference Manual (SRM)' and
drop the redundant 'Document'.

> +all the commands that the AHAB executes during the secure boot. These
> +commands instruct the AHAB code on which memory areas of the image to
> +authenticate, which keys to install, use and etc. The CSF is generated

'install, use and etc.' is not quite English - please rephrase, e.g.
'which keys to install and use, and so on'.

> +| DT property        | Variable    | Description                        =
                          |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| nxp,srk-table      | SRK_TABLE   | full path to SRK_1_2_3_4_table.bin =
                          |
> ++--------------------+-------------+------------------------------------=
--------------------------+
> +| nxp,srk-crt        | SRK_KEY     | full path to the SRK Key SRK1_sha38=
4_secp384r1_v3_usr_crt.pem|

Just to clarify for the reader - this points at the SRK certificate
(_crt.pem), not the private key. The DT property is nxp,srk-crt but
the env var is SRK_KEY, which is confusing on its own; please spell
out in the Description column that it is the SRK certificate. Also,
the matching _key.pem file must sit next to the cert for CST to find
it - worth stating explicitly, since there is no knob to point at it
separately.

> +See the introduction_ahab.txt document for the PKI tree generation
> +procedure (ahab_pki_tree tool) and for the SRK Table generation
> +(srktool, use the SHA256 variant for i.MX93).

Just to check - the default key material the etype uses is
'sha384_secp384r1' (see KEY_NAME in nxp_imx93cst.py), so telling the
reader to use the SHA256 srktool variant looks inconsistent with what
CST is then asked to sign with. Can you confirm which srktool hash
flag matches the shipped default, and align this sentence with it?

Regards,
Simon

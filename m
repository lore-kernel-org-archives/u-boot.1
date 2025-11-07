Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CD4CCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 09:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57E8483C94;
	Fri,  7 Nov 2025 10:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qsGi55Tk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A2B83CBD; Fri,  7 Nov 2025 10:12:08 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66FE483C60
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 10:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762506726; x=1763111526; i=xypron.glpk@gmx.de;
 bh=CzpfejjqAoM4H5TWmFGv7s35YvxW7Z0aDzGdjBm3Ji8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qsGi55Tk3q957uZOeAgChozmqklVy9ZdTj3wbbM8IhnJ4CfMsdWtS7YTvKpyp/KG
 hCjMCcjevCHpT7404JLQEKtm5lfy8QmaAsvv08Cl79wVGnqSjOoqEsntkhVhsjVoc
 RB/yp+HRMRKToJjuwLXM6R3eI4FgFMlQHn+Nt0htXTOeD+e0x2helRhgy3giAgRcR
 JuvVg0WYu3CAfZx033YN9sRDs6LG9yCK+eagFRBrxuOuBBxaKMzXsn4ZKHrP22u61
 WjgcWW42OilJfGw/YE7n4nBRdHoISvZ9UueVycEUZlbzcuQ8SQjHG30+hA1Ybw7Tm
 L/+Xp0oetylhllfeaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.183.149] ([93.94.208.154]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfYw-1vNs573hdY-004eBt; Fri, 07
 Nov 2025 10:12:05 +0100
Message-ID: <417e1b1a-0346-4297-9a72-7befc5b94311@gmx.de>
Date: Fri, 7 Nov 2025 10:12:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] kbuild: Produce diff between base DT and U-Boot
 augmented DT if DEVICE_TREE_DEBUG=1
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251106210826.371672-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251106210826.371672-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sYkJ09b8MV1U4k0xMDDqqw1NIDZhJi6ck39VyXqea7c+8S3z7En
 E5j+5kbH77FGnJGnxlIv2TluzLiipLYHOVl9OXlUbxdQrHXSP3TcLfdL1Fv8RlcPpLOGvf2
 bW6iaXYrrgS5Pz1YnzmJD6L+kOaqoMPfKW4w2ntTTZY5KCY3wpss2nr6Wz0tLCcmOgZVbiC
 g27ZQuO/x9edQalvY1Krg==
UI-OutboundReport: notjunk:1;M01:P0:rorKlvttcH8=;g5cuBZ2Kto/9jn0zteu4GC8xsBq
 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
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

On 11/6/25 22:08, Marek Vasut wrote:
> In case DEVICE_TREE_DEBUG is set, produce a diff between the base DT and
> DT with U-Boot extras, to show how much does the U-Boot DT differ from
> the base DT. This is particularly useful together with OF_UPSTREAM, to
> minimize the diff between upstream DTs and U-Boot DTs.
>=20
> Example usage:
> $ make r8a779g3_sparrowhawk_defconfig && make DEVICE_TREE_DEBUG=3D1
> $ cat ./dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dtb.diff
>=20
> This still has a downside. Even 'dtc -I dts -O dts ...' applied on
> base DT and U-Boot augmented DT can produce different phandle IDs
> for the same node in those two DTs, which results in a lot of noise
> in the resulting diff. The only way I can think of is to patch DTC
> to emit full paths in those phandles instead, something like a
> phandle =3D <&{/full/path/to/remote/end} ...>;
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Sam Edwards <cfsworks@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de

Hello Marek,

Without documentation developers will not know about the new feature.=20
Could you, please, add a doc/build/ change in the next iteration.

Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>


> ---
>   scripts/Makefile.lib | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 5db2fbc418a..2d8bf3c04f4 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -386,10 +386,31 @@ ifeq ($(CONFIG_OF_LIBFDT_OVERLAY),y)
>   DTC_FLAGS +=3D -@
>   endif
>  =20
> +# In case DEVICE_TREE_DEBUG is set, produce a diff between the base DT =
and
> +# DT with U-Boot extras, to show how much does the U-Boot DT differ fro=
m
> +# the base DT. This is particularly useful together with OF_UPSTREAM, t=
o
> +# minimize the diff between upstream DTs and U-Boot DTs.
> +ifdef DEVICE_TREE_DEBUG
> +cmd_dtc_diff =3D \
> +	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtn-=
tmp) $< ; \
> +	$(DTC) -s -O dts -o $@.clean.dts -b 0 \
> +		-i $(dir $<) $(DTC_FLAGS) $(dtn-tmp) || \
> +		(echo "Check $(shell pwd)/$< for errors" && false); \
> +	$(DTC) -s -O dts -o $@.full.dts -b 0 \
> +		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) $(dtc-tmp) || \
> +		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false); \
> +	(diff -Naru $@.clean.dts $@.full.dts > $@.diff || true)
> +
> +dtn-tmp =3D $(subst $(comma),_,$(dot-target).dtn.tmp)
> +else
> +cmd_dtc_diff =3D
> +endif
> +
>   quiet_cmd_dtc =3D DTC     $@
>   # Modified for U-Boot
>   # Bring in any U-Boot-specific include at the end of the file
>   # And finally any custom .dtsi fragments specified with CONFIG_DEVICE_=
TREE_INCLUDES
> +
>   cmd_dtc =3D mkdir -p $(dir ${dtc-tmp}) ; \
>   	(cat $< > $(pre-tmp)); \
>   	$(foreach f,$(subst $(quote),,$(dtsi_include_list) $(CONFIG_DEVICE_TR=
EE_INCLUDES)), \
> @@ -400,7 +421,8 @@ cmd_dtc =3D mkdir -p $(dir ${dtc-tmp}) ; \
>   		-d $(depfile).dtc.tmp $(dtc-tmp) || \
>   		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
>   		; \
> -	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(dep=
file)
> +	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(dep=
file) ; \
> +	$(cmd_dtc_diff)
>  =20
>   dtsi_include_list_deps :=3D $(addprefix $(u_boot_dtsi_loc),$(subst $(q=
uote),,$(dtsi_include_list)))
>  =20


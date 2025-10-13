Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A59CCA476
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 10:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A7083835;
	Mon, 13 Oct 2025 12:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PQLuw3/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFEAB8383F; Mon, 13 Oct 2025 12:01:04 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D7008376C
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 12:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760349658; x=1760954458; i=xypron.glpk@gmx.de;
 bh=QzOU78FWGODI1Be8BFQTylnycXsaMcTPnib353PriPs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PQLuw3/M6t2+n76Zjq1SMhbcQahsLI6yoIN0ckbSIn6S1AYV4/HUHbPbQKUT4292
 5TOSXShaEMZLGKm0GnZjMCB3sqFY7/C07xZDtxY3K2g/wNgauQRRioHHo8/qP7yJn
 cC18hHNsB/c0ywyqTE83k5uNKu66N9LLcCgYk3KdOeeG/j+PzqqSURSVFvoelvFNp
 kR6ERY1U8G+xrSl/OMVdBjlc0abfKKvBbIj/aXt1HQc8vX/HtreI/94qU4GGvHled
 PyoObRvq+r0pBMyVHfn5O+zruuRQWMGgG9RK19Gzyx0Z5CCbBpW1Cn0/VRTRGzWeI
 +N2C2rnP6CUhUF70kQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8mb-1ucUuN2HxN-00do4k; Mon, 13
 Oct 2025 12:00:58 +0200
Message-ID: <88c25ace-fa91-4f30-8697-9f65cf98959b@gmx.de>
Date: Mon, 13 Oct 2025 12:00:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] boot: Move obtaining the label into a common file
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
References: <20251012064412.2892979-1-sjg@chromium.org>
 <20251012064412.2892979-3-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251012064412.2892979-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yf86R4z+Wx1I7Jd5sERfkNTCGiPNiw53/QZbrJ4dSQ7ZIt4yBBq
 KzCjgOfkFwnLFGjvitmeuIUjmYQO18m5yDVY86Hvqoq/FjSgG5YxSqticB9KSbIaINRfUqC
 dy6zzfpihXjdSs17LSb2NLGJFa0Fknr+MVn1sXSxwtM+Vvc9pHFNIK0gHyjpPgquz1jOl0K
 lppNxAWECBnoNdK7HRe9w==
UI-OutboundReport: notjunk:1;M01:P0:nZD+C5yvFuk=;4ewRezgzFdrVRNEBpEyyNC10qax
 Z9SWSSCruJP09U0kI5GuY1heH46mRFoDV0EA3QiXz7ookiMiqcYn8sZgWJdi6VyMCb+1SQfuN
 FQvzGzchzcouzrqOz9UaEBdSLLspj3F28ibT9b11MXtoQ5wqTtQ1MtH8WJLjPaxq5ixgDNFga
 rq/JE5wVOzfkSGAJIqObNVwIixsN9xHxG8AlPVlw+zMXKwm5uwqzf2o/GN/ebEbkt8k4KN/GA
 CpY+pBttNZ+/+8a2djC37pxSAj3mphcU1LHkai9zSoXr1F8XX9cp/4v8DuFoNpZ/MTm7u8dfi
 UeAHnZdz5caZfyA9hxQCaV4ZEKZl+U2lZW3lE4+Up5MJiwaURZ9dUAkI4a4KwBLCvSRyDNpfU
 ABXEvHqHrIuag7yV8j+lfHTVAidC3L0k2sweM/015U5xbegv3guj4/iTosds64UkF1TZ9OFb1
 ZfnBVQVD88TULGkuUebFya8drpa+jC4LqfwKRKU4vi+oUm0CDU6RauppRye5H5AWgIENj1f02
 ichiuJrJi/aABJUTYKOVzPU6aM+0dxz76yi2YH5vOL7jgbeoQ4NgyOfKF40n6JOCxRBqbrIx3
 bDh4q8tH2z+Y9EzWaUddykmIKCNjy50pXIuFA9KCzrOuKuFrJT8Nj8B8MPuhhnfn8hBCxzmHE
 TdH0od9vwFrfJ2vOJIybi8Y+t52I+T0dIZopinLyznsSp+1mcEG21GiPUaJVf8FLU4qEDKTyU
 zqc3rg41ZP5R4RFqDbNiUxW44LI/K8M8Rc7qMWJDpyDKVulZrqS8rQeqQplBiNGBQpS3Joofo
 v/kCdty6D9OeWeWTpTNp4ekTWHNoGsb0U+ta0QkHo4Wk9d0Xwl9/h0URywxGLUoN/FHCDZrnG
 BdRGw2QIm4E2XydkaOhSKmiJGHXXcX7smO9pVm8yzrIAEvufVq0e2xwyliGkJsug5kUeW9k5r
 QYm1J9UL0umWg75Rp6wc4ltCzwI+GdtUHOPv3I01JA6ghSlfcOPmpzuIt1vlGRJkpAVef7ACr
 8vCQFp+npYwnGDNhUJqnckjG2Siw+mrsMQ4267D9F6hd45NZw/p1BwZrTM5Ny/nZCknHIh7BC
 nfrFiIxJIj8Z28h89nGpxeHEY/O15S5N4cyqyqVc44GcIA27lcUvpLa1Y4tR61l/wXeItX+lh
 rsldraO+vd9kAqdzAyfaKNYmp74OIdEYTonMqsnbeSr3lCmq7BPW88tGJHjToL+VChZ1soN6J
 xKSj3V+6GnEZ6FLEFpGxJ8RREEMC2su0rErlJTXrnkVJxXgI/iZ85SR2+EXWhYMmw0IsdSt/M
 sDsBXpNsypZ9+dLVqinLgmblY5jwoTcdmZ4a4jpzFbVPvAdKhWSOCjcz2b1pd8cuUjtuGfzHW
 zpXBE+Gmnt6A0ZwdP4yfnAi2zWvzIsU+h2Vt7gv80gm3dTTaNTbXdTj0SHMS9lH/kTuwdyTJ2
 xy4NvTreX3hh8OYZnYk2NKNFCsWgEJj9wfa/0cQCT7LC02Buoni/qOGYbEQTn9WF86t6MFhhG
 4aPgiNlQZmyCVp2lciGsxq48Z5Ufaqm8jRp13JaQmvlhC542+fgarftHBQATnCnMkDiMz0ZaQ
 6b3GX3RBo0Jx6Z3c90Ms25k+jID1duOK84C7hzYe5hfRRMKMSjWABvQWhJ6yMyKtIuy4CzLcK
 JoYpFlowqUqh4Lvmdw78kryfKJ9CitySBqQ7wh7sg8Wlt/lWSKUvhkhqaF07tIk3gvWmk2zWc
 SoRQSpm6Gp1zJM5UEao7Jk7v4BxiyE1v/dm7kE8xeRYC+GHkuXML3bgTJv2ynO3ApF1tC1zMO
 w+MXVvpWYhn0FrbmBiOzy11TZjXVurO0XXVnNBs9cXG8fbp30qJoW4xdszUGb6SY7OfPMOcMD
 /UzTbjMF1CUx7I+IJ85DDtoymqst4jpj39lw/9pScApsLu8GLVU9K7GYjvuv+tE5IGkhB9rqN
 AVh3Pv2C3I5F7Bs1vqjdJO6xZzV59Hb1jMCGpENe6OKTSbJvLQ08eZIRck1ZsrXX1fWK8xJ7F
 mTnVMixZeIzK52rb6MCQr/P7DPwvbsGFDEa9d6bsQARQI8qGDQZBwgfxzPUiM03DnIg26mlUi
 mnZWbvzRt4O5X1an2I6goXWJ5KMQFsE/GFiruheeuYg5vjq463sRlc7y7sDYbeAwbQ6rklRDe
 KqhQM6s4YTpFEt+HuwWEWvzSPcrSiJ4xmJEdbOmxGIipjDeqLZQEDzCcs9s/3O3p8dSl50p7P
 ES1Ceok1HKonEdnAcvOE4aUpmcrSSCAwRy0BA7Yj7CWdWs2EAbbfC1f1sKtINKP+0+Ibn7ANP
 rB/epM+F6CZI8qSy687Wo8WNy+6DR2nmuGyB+7Wbt87I4Gnd7ChRY1yAiy///MJQ/Pw/W64pO
 Y7lHNJMBTKsC9FN14M/B+u3QnD8fMl+oUFs4PPgE7JhiPJ+PoPOL4YzZP9zh+0iuHPkiKHggO
 DWtLPlZD8RUMZ47dIRhcSmgL1qaOlqCFyPgtbxfqwrAflp3WsM/3zWLAnW90n+gKPS83ECUwU
 B5gB1BsLcBSjUykL+fsEKvP0C4KGeirE4gMNMB1f5rIqmZsthj++n/I2uEmss9aFqO2an62Je
 T/5kbatwCpfFtbCJl4Ij41MthJM+yq1eUB7bGC2ls7YcxVFHUpdljoSp1tIb7R5qs9je1iPGo
 r6yrYi1tJzUS9TEFFrPlxstWfuZuPuyB0gg81wls0fTWXoq/nxftrOJ+jRVXiZC1KJI1qCOIz
 eHPEUsKtR13aZVTJ/MiGx1gLShpvoBr+uuNQa27lzYgj9pfwO1mcdDM9XPXuref8LlcnPbiHJ
 qpmxsu5VsKZlbyqQt7FJq/UVzBGodrMKzQClco6MlqwNorNJ/Wf1O8UAwYP7bF74TDFAEboSW
 fjA3JRgni+a+Z0D2wggsorarjNN4XMgojn2veufBDPouOXzp135D3qnNveErfIKzuVdrzTxbD
 mjCPQt/PgI3Oag9UojFFzJcSoZLbQLW73Ds7LVhrx6Zs1BRtmpp7uu8UjqcMVFLQYK0CedVEo
 NgproGQwI4neRJDDdtNa5aDZN86+P4rDsAHIvLPnKHFwSLgGJ7l7qMejNlRlyZkLzcEdZ+0sM
 +H5LHN6x0BJZFzp9cyZHJ+aHGC5qzhjwafmv2liVdz8fuIwEVC49V6fzeu8ow00tbwHPaVcAH
 ufJDIW6cDSvcwgTXijbQtVP39XEbZQyqz70cHJVkJdV015xZjZ7+17dUvht066etvINW5wWdA
 wE32hd3PuPETI5ZfkdJ+OdmNMOfIWTXLSgfUgUCCtJ5hNIsni34JjzPXwmWdfBU19+05LLuQz
 6luNQPGq5I+K22FXy/kQPldnkEjVs69qMKeRJnyebmWib1dMBVfen2LMUgMYVkgaozslL657l
 gvIQhsmgLAAOT2u9xr88H51YpBMFlL/HLF1Bg1Xhkn3wjGwcKQQNvB8Tt9nH0tjeMqlEVdjfw
 aZ+LlrNGr2fgfJUQNTAZnOvkn9wF8R9XSfc/eFJniKAS4a0dGLVknX3hgqZqbIj2uLBSBU5TO
 5e8aA0kU7Bn4KTuRMUzH5mQgf4eeVGkfWI4/jxMP1eX9GXvTq60G5Idft+pz1pr6i6vfY6pJq
 SdINRq74v3SDKjMXpWvsgryRiejekuDo823LeotxOpS5hLo2hJjC3OowuqNAXDXV6cPdhg2KR
 e619UefYHrCo3WKvuuHdUxj+9iUs7E0FjB2DYugGza5oAZForW6K9+DdTjfzcsTT+IwYchZrx
 98RBhHGlKlEFeyOfT92yPELqgqRcUal4/6x98UDKYZiR9hC9ALJITakhfgH0DnswwsrIfdzmy
 ydfw7ThicH4iz3MFF1i1xdsHDzCf2JINifh5t7HL8MibW/M2P8ATjqi8Zc65evRp6TeE8t6iu
 RVTOkXjUdvhOPNpJW9sq/Qgz8A62WLtgL90lbhJAZUVG3rHLkShuafp+i8Yyp5YleVP40H5l+
 GFuZ1epb8UG5C9/2EyFpN8t5MzlrnJv5ld5YeTmLkGDl4C/htKzyRfFjCRKmvY5sHLdG85RVF
 zlGKdb03F3G/KYai0Ly5isHAJTsVQHIl4feQeZhkMyF4KY1eApsnjb2H6mZtCVou8BtSc1IbI
 GgxfnpLxeF5RG4E3CRQq+Gaug7bIJBEDCbqAFkNSMBLojzhs95cAIKebY+tLCx0BkVEHs1HK4
 rs3fvnJ/VZMP/1ls5A0bQ/DvfNBlVOZzrTyJsybwxmfyDYp53ozUFREq7MOM1R6V4UjqC3u/8
 AtoVbfLE+fev7iC59sEWk6YiLNwf+lHoYznhqsQ8p7IGe3od7wpmMLCcrhbaoRplenXmUvzUK
 USxaZ3VTC9nnQ3LOrvpkYyQDKsExnquN+2SSktlFUzqYbV9czhbb3ooejUup5x/xtX+zyoaCt
 +vkJQoJwSrPQnezA4RnrATx4As7Axa4JXC7fcuUtVTNpNpc/MIscs0xQBt1HGBXnHoofrTRqw
 wXEZUJboKXX46XLD/MAzC0IyXzLZumh6NmP4ZRB5rSytvSGz74ufA2l1dLB8/BNuWPCdfIrMS
 pzpPIXYnXoLFA7go2XHJ/wHnNDU2KAuViEb2lE/CdvNBIjMbB/oBMV6S5mPxm01lNbLcSgxdT
 neH8v/n3F78p2L418Fjce7JcAMUDtbvz1DC8xYXUkEi0LnKrR7e1PEEOix1YpYzMYm8Yu/kTT
 KqY1rfM3Y75hsiBUw/l/cFda7AIiofbZ9KRUcE3EeOWUyzl5VE6c50OoXxT55Sj+1CyPFAu81
 RMKcXtbqpRr94Q69WHA4h1iNfGtcdTpL5lwHjuvriC7RNOf1ytofz0qUNrWSTnveIdORA+XfF
 apfMxPdVh2uWvEotRXNXXxKlcIBxX4kF1eMzphV5eKDWvChwt/yK/3PHHbXoRmSRVCSQFo0yD
 imLrNYC+4hKVr2+Zd4CRMPfNIjMi7lEMmBlUFiuGMcOToZMHsP43K5JqdwpeGSK26xU4L6H0p
 XtIN9/7PcHRUTyaedZSBpt1zJVjp9y4LfcM6d68JnG1mSRseder9tjZgEoGSwkOqps/W/O3tD
 nzLA1dQUdYg+e1sR80bOvQNayUgdgla8h2rDxXosgfTqUNnkM3erX3ecESNkcLwm9rwgw==
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

On 10/12/25 08:43, Simon Glass wrote:
> The 'bootflow list' command supports looking at the EFI device-path when
> available. Move this piece into a common function so it can be used
> elsewhere.
>=20
> This updates the output from 'bootflow list'.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v5:
> - Move 'usb' rename into a separate patch
>=20
>   boot/bootflow.c    | 16 ++++++++++++++++
>   cmd/bootflow.c     |  8 +++++---
>   include/bootflow.h |  8 ++++++++
>   3 files changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 15df7069209..6485d473d69 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -11,6 +11,7 @@
>   #include <bootmeth.h>
>   #include <bootstd.h>
>   #include <dm.h>
> +#include <efi_device_path.h>
>   #include <env_internal.h>
>   #include <malloc.h>
>   #include <serial.h>
> @@ -1010,3 +1011,18 @@ int bootflow_get_seq(const struct bootflow *bflow=
)
>  =20
>   	return alist_calc_index(&std->bootflows, bflow);
>   }
> +
> +const char *bootflow_guess_label(const struct bootflow *bflow)
> +{
> +	const char *name =3D NULL;

Why would you not return bootflow->name if it is allocated?

> +
> +	if (bflow->dev) {
> +		struct udevice *media =3D dev_get_parent(bflow->dev);
> +
> +		name =3D dev_get_uclass_name(media);
> +	}
> +	if (!name)
> +		name =3D "(none)";

Label "(none)" makes no sense to bootflows created for BOOTMETHF_GLOBAL.
Can't we return a string for the bootmeth instead?

> +
> +	return name;
> +}
> diff --git a/cmd/bootflow.c b/cmd/bootflow.c
> index 551dffbb8b8..5b803d4ace5 100644
> --- a/cmd/bootflow.c
> +++ b/cmd/bootflow.c
> @@ -70,10 +70,12 @@ static void report_bootflow_err(struct bootflow *bfl=
ow, int err)
>    */
>   static void show_bootflow(int index, struct bootflow *bflow, bool erro=
rs)
>   {
> +	const char *name =3D bootflow_guess_label(bflow);

Why would we guess a name if bflow->name !=3D NULL?

> +
>   	printf("%3x  %-11s  %-6s  %-9.9s %4x  %-25.25s %s\n", index,
> -	       bflow->method->name, bootflow_state_get_name(bflow->state),
> -	       bflow->dev ? dev_get_uclass_name(dev_get_parent(bflow->dev)) :
> -	       "(none)", bflow->part, bflow->name, bflow->fname ?: "");
> +	       bflow->method ? bflow->method->name : "(none)",
> +	       bootflow_state_get_name(bflow->state), name, bflow->part,
> +	       bflow->name, bflow->fname ?: "");
>   	if (errors)
>   		report_bootflow_err(bflow, bflow->err);
>   }
> diff --git a/include/bootflow.h b/include/bootflow.h
> index 2ef6eb25cf5..657e3731f11 100644
> --- a/include/bootflow.h
> +++ b/include/bootflow.h
> @@ -692,4 +692,12 @@ int bootflow_menu_start(struct bootstd_priv *std, b=
ool text_mode,
>    */
>   int bootflow_menu_poll(struct expo *exp, int *seqp);
>  =20
> +/**
> + * bootflow_guess_label() - Produce a plausible label for a bootflow
> + *
> + * This uses the uclass name or EFI device-path to come up with a usefu=
l label
> + * for display to the user. Ideally it will say "mmc", "usb", nvme", et=
c.

Please, describe the fallback.

The documentation is comprehensible but unfortunately incomplete for=20
what we want to generate in doc/api

Please, add '@bootflow:', 'Return:'.
cf.=20
https://www.kernel.org/doc/html/v4.16/doc-guide/kernel-doc.html#function-d=
ocumentation

Best regards

Heinrich

> + */
> +const char *bootflow_guess_label(const struct bootflow *bflow);
> +
>   #endif


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B6FC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 16:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 897CF87C38;
	Thu, 25 Jul 2024 18:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Iw/IiuZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE7D87C7E; Thu, 25 Jul 2024 18:03:00 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9520D879AF
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 18:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721923377; x=1722528177; i=xypron.glpk@gmx.de;
 bh=t2VDALz3+trI54z1vTIbe6AqwabN63zDQb6ITudIU7g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Iw/IiuZDhybV/a3XaBMOry0m9wnv3bEnazixOCnFMvW7PZYvg9IFHZJ/Sjh/59z0
 LIcZ428HAKCf2ny/ULwrdVvdZMDSG0Lq8/VfawmF5VqAJocI+/6x1fC1m9r+uMRWW
 lDB5z4VBYhcC9cNPRR0DAgzhWas2uhKBxS1d5dJV9oN/VoB4X9dPY7uyXgu91ME+1
 YVZmh0+qzswnt4pMrZqseHXqiJ7qsJodhYYAM9wGUFQ0nj1ubQZwLEOfmW29I9Ubf
 9GunOEL2755SXs8ctBWWV41YlIY9+Fssx7dm7gck7wQq7g6mNA92dGlIVq7RDw0u6
 1yfefQQ66LUtt889bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1sX0vg3q5I-00CnGY; Thu, 25
 Jul 2024 18:02:56 +0200
Message-ID: <ee3b019a-a0cf-4029-8bce-22515fbb48d6@gmx.de>
Date: Thu, 25 Jul 2024 18:02:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] doc: Show more information in efi index
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240725135629.3505072-1-sjg@chromium.org>
 <20240725135629.3505072-2-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240725135629.3505072-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yvaJKB6lbX0chcPZir/gGrc4khqqMHGF4WCeH1CQfP6Xvf7XFep
 AX0OMqb/HsBOAnSQcPJdbl8sr1DQlQMpUOG1rrqa3IliBK86NaQ/jw9PxIRsawAAFh1sxgl
 LraucAv6v6Zl3XXRmzIhMd8iOaW2IDg0GzJ+i44KNL4UvG0bX+99S7peITzpSjeRnl/rain
 v2J2riWkaIvsm04joAtgQ==
UI-OutboundReport: notjunk:1;M01:P0:Pd8G7rWEVVk=;BN1DlouBsgIiotgUTFUK8E8AH4W
 b3VCB0Fq+fiNkputbk8cPFoGKBL2n6nGXGNOJRtrBcjXWVrv8SOZjbSpok3z4m2/CfD8o6SHc
 z/0mQl7LK319xa/zmo/1PFUICUHAXqpXb7ib0xuyIgiKvzz+vU/VwlDhNo+/jebE/vMrDEHgd
 NhBiyRBMLxiYBBAzuZVqpOAAR/ncAgx5FGJWog93C24i+Nwd/aY22ufYGaSga1mZN1RGP1St6
 SbpeE9LY0EzOJgTxPRrt1n4vO89mEMTOcmNB1KW1l9/BR0s+rAtWbU36i31hrBLJgOmt4SamJ
 BZJh40vPHbEpDSRVa0sItAprKiTY/gHS8t8UQt45s8InixDpqTbR+z4shx5j6cDAZK7cShxki
 Ct5RiwmMNh+q8k1NOOUV0r02tk1AGeig5IUyOK1+KzbxVuztQHp2dS8rIqH7PIaYmeB9L9UbY
 /viHBs0+HdzYl3/wStKRpeemPuqT2PlOaFENIk+0hLtBECdo7t4wtuXJgE7/itmW4cIQEM3Fn
 tWyyjyVti+DGETuKs8jFztjpEGSBGikl953g7Sz0rrkcOnQcicFimtgXb+gtlYWQY4rvZpEo4
 27Mk10IAD76c/q8S8vzqB//Xy0E2wey5J/yuKfsmFBVTJqL06SuRANcGFOuOe+0VbtmAwswiX
 xvKoCnXZ3qkibdmBLbQ2c921kj1i3VfLjqN8Ag5FGWmSnEOBBeImJ8UxyGUJf5gr/QdnpUkin
 PwGZM1sw/vxlv4JfNOopX9fJNNjiBsFJkTt2EXEtlzovOJB+3JtgSJLzmLVB1vl5KLN7oau2D
 KptAEoYqHxrS85Hfg0GprW2A==
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

On 25.07.24 15:56, Simon Glass wrote:
> The index is much more helpful if it shows the next level of headings.
> Update tt.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   doc/develop/uefi/index.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/develop/uefi/index.rst b/doc/develop/uefi/index.rst
> index e26b1fbe05c..44540e8a537 100644
> --- a/doc/develop/uefi/index.rst
> +++ b/doc/develop/uefi/index.rst
> @@ -8,7 +8,7 @@ compliant software like Linux, GRUB, and iPXE. Furthermo=
re U-Boot itself
>   can be run an UEFI payload.
>
>   .. toctree::
> -   :maxdepth: 2
> +   :maxdepth: 3
>
>      uefi.rst
>      u-boot_on_efi.rst

What we really need to do is moving usage documentation like

* Executing a UEFI binary
* Launching a UEFI binary from a FIT image
* Run on VirtualBox (x86_64)

to pages in /usage instead of having these as sections in uefi.rst and
u-boot_on_efi.rst.

Best regards

Heinrich

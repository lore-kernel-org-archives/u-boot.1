Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E382C54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 12:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B915875B1;
	Tue, 21 Nov 2023 13:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WxUZDLnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7086A875BA; Tue, 21 Nov 2023 13:12:10 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EE97870F8
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 13:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700568724; x=1701173524; i=xypron.glpk@gmx.de;
 bh=/GR/omsly7ITAKKTdlPVpg8h5YMdRuTjhe6Hs8qnzVA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=WxUZDLntWjqzqkafq4ZPCAc9HAp7kEEdnt32RF+vui2YXhbEJNSPGjr3IlEz0t7d
 NoeTjn27ljd2/FjkhJt1e5tBIT2ow3AfqtLvXK8OFVcO3UVy1Xhnb5sTeu/AMCRk+
 Scioi7JxafE3gvL/7f43Wpp3+jXBq9DH7sgjDxYtucT8qcWqzYd0Cvr6InUIP1RjE
 QLsVIULr7pbT4APJyMpAO9wBMH3OLTdLDZsTpT06nH9UiG68RwdzaMXVYfJ/SSKJr
 AWiubR/p+jM6vmOZPTQYT0285F+NDAbX3pvWbQOhzypeu/60Bex/Wr/heSgUnt/a9
 1ZgFTs3ZSQB4RbXGLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wq3-1rTqMH1RhR-012EG1; Tue, 21
 Nov 2023 13:12:04 +0100
Message-ID: <ff17ba6f-a673-4ff1-9716-2486a1611079@gmx.de>
Date: Tue, 21 Nov 2023 13:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] efi: Correct display of table GUIDs
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231112205516.183410-1-sjg@chromium.org>
 <20231112205516.183410-3-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231112205516.183410-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:suCJaT66NPe7fB9CmjgmkI68aU27cxVNCyA9JqYGaIPGN2E/fGE
 dzcrBiQw95CMKxPnH9YRgrwufMzAoIuOLjuAQGgWX59yz2qpdqrMUX2C9OcevsdQ7qzDiQR
 wcGgz8tiEZJ3sPawQMdcI+j0LYDz7yvFrdz7pBxelGlH4iZ7ro4+Uv04T1gONXVALoNvsFt
 zhjSzVY9fUCbrGe86IRmg==
UI-OutboundReport: notjunk:1;M01:P0:+dvYprI1v0A=;sMU9N//AWDVV3eryz8iekigMtah
 wMSZ8x/CLhXhBU+ouY38jhD9cC6F23XtnsoltaPQE3it3SV5p/y8EoLf14ElrN5Zl67fHLYP2
 99mx6Vt5wG/a7TClyNwLS2AEM/lTrR3jiswP8yuT/S01nND6FhhNOMGhnfsbPGqzHEQygbipr
 hnt+fKbfARPRZVJmfhnpkioAoWsqwdrfFtvM7FIrpiwKZ7kgh3GzY17vfsXms3GD12UXkCgF8
 a8vbv46pPJAXAS98HUom2ktTKk6IcNqGalExCD9ZtDQzI27m53oohRjGaTJJfMPCoWj2QFOX9
 VTqxpKmP+AIn/XqVv1opKkQS0diT/wm+plIYzMI6S4qe/9se4Aw0AfTpVR8S1dUpeWgw+XhDI
 ve+LRrvi/BoLuAeWKCOrBRqS0RYxinUizve1Is/VE/q6/xDd2aczOzpBn2KUN4ozPFhW+w/H7
 sBf/nI68XEJZTeG+rX5Cc2vftTVZeauZvll79A+NmUBSAH2TVnXtRbRqqJ1Fk81d0q3WZsTkU
 338e0nuPIJQxLBnNqv/0L2Mao5xFddpaByINDR0mEernTxVxpTFRXBMCLK932MzH36EPf9sYJ
 6ew+4d2Q2nQh3LdvDtEnJHRQuAuAhLZKuId9KODaE4cmKWdqDF34R2b1/rLGfgj61i95O+wQ+
 rxMDowyv6rIg6j6fcg/zouKdJCv2JcZxgk8aW0A3nU8+FBLBq7ywzIRcbYvFndbbQoKYKFCXO
 eILG5VInRDAS00zzoiiRZCsI/eK+vArVylr80t6ZTfYyVz5GGqEoBje6Z8b5RPKLPvboPYQ/A
 ALe0BiWuOkPl9MFqayY4rOih57KNYGNF0qeRNU/nPDOq/Ih4ejYAjNQ3Zuh2Hc+ljt4sORyqv
 eSXTAvLNvwfZZShtJCroyjTvF296SuYtL7Y9vzm8v3K/P1mKFQmZ8EG9SEpyg+Kh+VKxFYqq/
 IyVa6g==
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

On 11/12/23 21:55, Simon Glass wrote:
> The printf() %pU option decodes GUIDs so it is not necessary to do this
> first. Drop the incorrect code.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xyprn.glpk@gmx.de>

> ---
>
> (no changes since v1)
>
>   cmd/efi_common.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/cmd/efi_common.c b/cmd/efi_common.c
> index f4056096cd3f..1aa2351fcdfd 100644
> --- a/cmd/efi_common.c
> +++ b/cmd/efi_common.c
> @@ -17,10 +17,8 @@ void efi_show_tables(struct efi_system_table *systab)
>
>   	for (i =3D 0; i < systab->nr_tables; i++) {
>   		struct efi_configuration_table *tab =3D &systab->tables[i];
> -		char guid_str[37];
>
> -		uuid_bin_to_str(tab->guid.b, guid_str, 1);
> -		printf("%p  %pUl  %s\n", tab->table, guid_str,
> +		printf("%p  %pUl  %s\n", tab->table, tab->guid.b,
>   		       uuid_guid_get_str(tab->guid.b) ?: "(unknown)");
>   	}
>   }


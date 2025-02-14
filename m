Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62F2C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C9280C98;
	Fri, 14 Feb 2025 15:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MgwQ7oCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8370380E88; Fri, 14 Feb 2025 15:41:24 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7221580B98
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739544077; x=1740148877; i=xypron.glpk@gmx.de;
 bh=5HqhTEORUgjgGcnma0YCYtcBVDNvcSl2ZskCzGmnS80=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MgwQ7oCcy2NuVjehHpAPX3sjEH/0MyNz9CDvueKb5HQUWtJXpkx6aoyigiKWmAfa
 0OTmVMmav1lFNMYUYRVHDZI4cXdjaPRc1T0eQ5GiuPjMg/hsxRqBBWxclszeJe6Ja
 bdU40yc77AluhfF33dZ7wgIDHIDkRddI15937+KZtAflD/s/Q2+gsazE35T7vmqYV
 1H0LHJDqWVfIeUE3MzB/F3+5NghiyqIJzZm60bUmL5rV2c4VAClE4Ug/u6obgr1B7
 YRcckTo6RRCAtCGEXXuehBf2ozGQopysFX0R8Q3NYZU+Jr5sxn7Rj8PW5lsx2CZau
 lCibaHJHs2hZWDnCMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1tI6P91OIk-016SU3; Fri, 14
 Feb 2025 15:41:17 +0100
Message-ID: <8821a103-50b2-48c1-b919-4a0462f02e6a@gmx.de>
Date: Fri, 14 Feb 2025 15:41:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] arch: introduce symbol HAVE_INITJMP
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
 <20250214140031.484344-2-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250214140031.484344-2-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IulJChHW4X52tLCWz17ZblZjaoGB3cW8SPwKvJ7t9DhXglcM5yt
 6UkwFAoUEKnHmMaX4cf9dc1kD+O9v6dVVb1mx5d1xnXF9iQSRmCDAwJl2OeFUuBVnkUwHdt
 2Xs/Hzuas1MQpVt7kxiPlY2gzubyaKx7l3PlVQVGCtt8ESj6Zkv5IQQvvzMQMO5HGkkA33F
 SzH/KrDG4yzZT4N/KWrTQ==
UI-OutboundReport: notjunk:1;M01:P0:DsH83jx8uvk=;i4Z+dz+EdBOxM4Tk6zY2DZZh51O
 ixZEBFOkj4wXqvdh8kkIYlAdY9+oX/KugFZ6EVY2ENsGIlX21n8aryXNNpvaCIMxnsLefyffg
 5h046H8bTpWsYviT36G3/enMPIy5psv58Yko3wXgLE0GJ4k3cEpUBtulErQ0W7zR1EVQHsZF+
 miuLOPrzPFtcYQnvMFbo6v2Odyc3jP9Bnhq0BX7TnCRtKt0qYPHFDFjs7S5nix59u3erB+P0L
 HqVAcr92kb11iZSsF3odU1uf4jgHg8uRBT9mTl4auAUR9HizTBo002RsIgRiiwEVcJhXmpaM+
 DPIq6pxFHIZ2aUv+/QnMzuPhXAsuikR6vW6CScYLjvswsbNj0qifHXWqkml4aAQ53IdUIKvbr
 VIU87uw/JgB4aUtF202LOPHakc4xFGYbDWtsbGnU+d5/vS5W5QXOwgH+uKU23LHBE0UKOOnZk
 LoFNWA/FA675WS+60EqgHULBNU9B/kV+y3AYqxIsLxdectTzuntEadtUoQFhB11xXMbYFFEkb
 R2mDmI+uOBYhGHTYBTGj6+ahmaJVH2r0RcEeIOJjEDjroawrMM/qa8MXTxoHUQjubte96XQOD
 YWg85mbnEuRJW0EEEhkDL1l8SVPixaV1dYLbtYj+RwsXxMlwkLI592jKSH0IgDSXZ5y2i/AI/
 9koNb2s4EClbYGhOo3N2g6GxiEqkJkNGxdm6RPIXEmrQmD5Wfd1x3ugS8r3sGwOxMIm6f3nWC
 6JrVRa+RJljJk+IxYbj3HRu3OLHlrFkNDsD6/OkwzeZ4G2/BfMN46GwsQt27nBiFvqGsppp2C
 eTlCYgiAHyc2k3OIQz/i5loylysIFD5D8iUxsprFCzw2DQlM5GQHqBdqQwxJetho+pXTkgPiL
 fJn9tghTVsO+0jn/Lg2bQWTZ4zhFmC7HiJVaP2O/sx2+EGP9+B3OlgPgugduqQCUNWIzgOVB2
 p5TGGrk6evBvSnL5vFSp2uvcogfGghqZyq0KMCsJTKf5qryStJhpae/RkUBdtm2RPZydCDI3s
 mfljxvWH8r/1dml2icJFVo0B984QIB7Gf6dELKfRV6/hGNqPTpjUKAZNCLsn78ybBaC2n9JPk
 q4awkfl0LJLsX8iYfo6eregoKEwqcDsWglPX+WBRu1EqVFR+YR7BaMCEV0YE9jqF1zLpApXkV
 eXnSTAWeAX0TurcBCCqTwhyUX3xjPrgzU7yaDmEIVjlC6BGFoAlpUuCSvVqdRg6LDG/ZCuX0P
 eVxkimxjFoQB9OtZyl58HkLwx50JU5er0P6mmZKZ3x1mY4kg19MHdoLJSOsTMZv5/TUByMR72
 cWcSnzl8yUJc6jveokyp9PAjfPratnvpsJ1CkS2NxlnHR/lZTC2zLsiphJk0Ahs5LdJaSwRyT
 OSZkyZbo08iFmovwlI0Ch9qG3bbJoCHlJAYBamJl8MLJtDPtUAqOhDUQU2WdOSKtmmhtbDpPr
 Mvw1J/wmrscu5XjvZhgU2uIY32h2q0mRvd0rGZmR+aG18uGy1
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

On 14.02.25 15:00, Jerome Forissier wrote:
> HAVE_INIJMP will be set by architectures that support initjmp(), a
> non-standard extension to setjmp()/longjmp() allowing to initialize a
> jump buffer with a function pointer and a stack pointer. This will be
> useful to later introduce threads.

How is initjmp() used in threading?

A cover-letter for the series would have been helpful.

>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   arch/Kconfig | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 35b19f9bfdc..8d5b54031b3 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -13,6 +13,12 @@ config HAVE_SETJMP
>   	help
>   	 The architecture supports setjmp() and longjmp().
>
> +config HAVE_INITJMP
> +	bool
> +	help
> +	 The architecture supports initjmp(), a non-standard companion to
> +	 setjmp() and longjmp().

If this required for thread support, I would have expected this to be in
the help text.

Best regards

Heinrich

> +
>   config SUPPORT_BIG_ENDIAN
>   	bool
>


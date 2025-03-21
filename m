Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954E6C36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 14:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B97805C8;
	Fri, 21 Mar 2025 15:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cAvYSwnd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CDBD807D7; Fri, 21 Mar 2025 15:47:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61CAE803DF
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 15:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1742568451; x=1743173251; i=xypron.glpk@gmx.de;
 bh=LDGrmnThbf2mnkvNd00KOXSxy9qOt/Iqw/+6lzGVO3w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cAvYSwndl1jcHcHjr6JbIz8GdlGjzjOYJNrp0EZ77RmiLqb2CVexjK5FwnDdqXiN
 umDIHDtk2o4RBwQJuGiHHvZAydXtpOlRyvVlr+Dbmlw5MhKPolzi+IvSO1mxM6FuD
 2Sa+7apfwN+00jeSC182sLDJmbDwhGNVwfTBOM4ZKiS0ghlB32X5Ref3utf1bm+OO
 xd8UC5pPMOw/e+M6vEPzybFi1qEZ3ydz7YqZugEPuLPfVUpz2FBeIifd/483pmXQd
 fWDNIq6+bptoEF/HKacdhzLzO43A+UrhNh2q3+CeSb9PA8seCREcla23pGGSsgAD/
 3Xz3ORcunK1H6TOOVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsQ4-1u4P6A3oQa-003gVQ; Fri, 21
 Mar 2025 15:47:30 +0100
Message-ID: <dcdecded-ac22-4300-9b41-29257ebf9e5e@gmx.de>
Date: Fri, 21 Mar 2025 15:47:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: remove commented out line
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de
References: <20250321124216.1268147-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250321124216.1268147-1-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P7dUYVXmhNhSkdfyrhyoyGFX3/4Bl82uO0psCyGQAoA4D5+Io+x
 TqZwiOvizKQ+eF19geqFP3rKBlj8aEyEKPMaXreJ6n9ExHUvNX3vcZYTYw7oXjaVNyvUctj
 GKcxku7g7JbWrbYnHf6Y/dAAt3gmMYSiGRuxHNHwgLJvHpN7x2Vipnx1K+ZFzGOUmxV0xJY
 cLeFKXunyA02a/XI338+A==
UI-OutboundReport: notjunk:1;M01:P0:5BWUi8lAdPk=;ASGbPpR/L2RQoejP/DI+7xagYgV
 +rq519hQGXfCPykwegYS59mEjjdyGaLPp/+3ctfCCB+XMrSVCnPJHVStyIU4zc8vh+LqsWB7X
 8Na7YFDOI/fyHstPIKb4N/SqYio2qB9o9nTD0skxrivDmeNjFcDfyCiRwzHUEE+5WVdVE1oR1
 hDEtJZ1Mds2OmnhVvmzU1nvaQDkOnXAfJ7zkH00FcrGyQcezbKYkGCHM4UATj/2Zs4EKGxujS
 H9Ai/4JWhGmV1BeG5+Jh/brK8NWVBUjjqWTf9KbU8ikyXLlgG4/jV3gwyFB21nJ2We+Z8t4+P
 FafH0mmhyj11OlP6bu5ag52bEvcWDHjIoZ5HjtsfpP4UJRvn4g8QVEbwQDl9reEOK4bR4qGAq
 i3CsxiXRuyOCcGW0fztbO2VxOkJYCLaWa//IuaKM+DB44yp/TSx9PxVMjp77bR3EZFZicAhXx
 /1U2YWs+DcyCx72IGTAfODlHwfcJ2Qu3mn8wUVf8w/gbEH6nNgdXCfhzMXkrsd1sWT1wd6G/l
 HZYGchWUHLhRoSUr04cjNB1a0gpSGBc3GDgCdRIcufSXVjzKaNDJ7zQlewVsfUKzwtjWCnfAN
 oexTTnM8OVKzuILWYipyv3cT2/XG6iiv1XLaXJXLpYzYqsVuRu+UdynLOw8PZkU1hc8gImOYK
 PDqOI0coYzvki3QLghPOK4xqVqrxfYo0x1XQpIUSOtzSPchymoshyA3AlvdNof3P+33XcgiqJ
 daR8e/OakGieFcPbgms/ZLLTuZhR5+4lN6Q38DWLE+tbLA3/PMrMPgqzIvDOlAbb7pahK/WCi
 6Dtj40lHxW7zbWfDmbY/ZCEaA51e+vKSKBe3mHhdhmPxN3QvkpzcnOdRGA638SQSmkdo2lZ3t
 F1gNbf4BQa6N4WXkQgUgI15i+ZgnhweN9o6vZ1LTCNVvqU1doFt9WeFgX+PKKlrOrbV3cZxe9
 O69yj9PnyRWr8+3sK3nh/1MK0jx2GoFUyjwG1SwnzXfKpkYGRytWcIpEprEKzsJ77/4Fxo14S
 mRZucTur4s1UH82lcmFqZ7+RGWXruPfO7DwJUWa3Wmm8jYY1ysPWvi0KjNgKLDw3fKFQcEfcJ
 xTM9WuXzr3IQ3Mp0rs372Wk0D4pfgs6wuoAvxltcp0PRI/D6aWlOLAb9Dh9JVi51ws6LOPrNZ
 hPb76fpMoTjvBUdTjoIKP8rvOidNJhluLL75Om8HMuJtEvUBL8XeKgaX61/wq4R5mq/m+KKMN
 cCfJVxMTeCsi3iB3uJYDm5Lz4ajxhn0HDRlzkrQWiEngsYZPDJyjRhQ5CGvF0oKIdcrwAi8W+
 b86VlQeNO88YV5BHLMICrPazNyaiipAf7LL0ktoxPdICBFqZuoX39/eI4oHYxdydSpRzYYTI/
 Kse1ZQ2VqvDGZPU6tcPaePaK8m2DsiFprX0dfbP9zZ7steFOa5TNoi4QWiEI6U6dcCuCc3Qn9
 i3eSSONXIZEOmpqe6JpsZjbWzhPM=
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

On 21.03.25 13:42, Jerome Forissier wrote:
> Commit 1d5d292b7941 ("net: split net into net{,-common,-legacy,-lwip}")
> inadvertendly left a commented out declaration for do_wget() in
> net-common.h. Remove it.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

The definition was moved to include/net-lwip.h.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   include/net-common.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/include/net-common.h b/include/net-common.h
> index 29d31f37263..89679e20860 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -518,7 +518,6 @@ int wget_do_request(ulong dst_addr, char *uri);
>    * Return:	true if uri is valid, false if uri is invalid
>    */
>   bool wget_validate_uri(char *uri);
> -//int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const a=
rgv[]);
>
>   /**
>    * enum wget_http_method - http method


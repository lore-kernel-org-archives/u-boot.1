Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EFD606A326
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aAEypfnm;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=baodeep.com header.i=@baodeep.com header.a=rsa-sha256 header.s=dkim header.b=DqiB4M36
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C4D680D45;
	Mon,  9 Nov 2026 16:08:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sQUM3WLgVIlM; Mon,  9 Nov 2026 16:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 909B880D56
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794240493;
	b=n8mqrtx8oiKlaORoHD2VFJcM2Hnek3stg2E17Xhw26QQmo6atVSwFjc8gzdWFNMenOjz
	 FQxkvYApCUAGczGjfK1jhard+Y7OUvhxyZFdRwqzQEOOS7AYSfS0I2fpKpaA9uy+0mwRv
	 uGRlZlGdoMKY+eEi5SHBLDXdrWHsw/KJIeasl72MJ0MRMeDog//ufIyGKk+fLMQBjJjpn
	 KbZ6ykhpkINzfGynK2wAGZgC86dmciUdNzs5VRWTMO7lSQ7on3HM9Zb348YqSNF7s3GNl
	 qrLDkxAoBoRd4zIhbFmIE3e/D0cwaHcvL07ljr7qIoAXj+T5mO47ysC/yhWfG4PDwuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794240493;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0+TsU8RcF40B0MjbzqTGoI0K+wCZQ91px5Jrfv/6NMc=;
	b=BVp9Mae2ORF/VdHSITOWB07WL7V5CmN86CdH8uR3x1cXUrrDlTrFPR36p+EDlMNG7feV
	 HQ+gJQuhjrai2N8tvFV40CTOkF4SLRDs3BwdhyQXDItwBTBNW4Z9ZTlFpYYkJG+Dy2wJ/
	 Aj61OtA2cwoeU/YHzry//llxvq4F6K1u3ui0JGTx7poP6AC+ZgUv4kJCmcs25udVXK3xh
	 tvUYXo+rRxFi+BiBceuWFm6SpSPOky2iu4hpQ/KG8JkKLArJz4nXC7EweCo+67xOlBIhg
	 OqxSPZnr7qE8JARDqA31qdklCoJXM0AkhjN55T27SJbrA/PKwz3loFVI0OU1ylEhUBg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794240493;
	bh=0+TsU8RcF40B0MjbzqTGoI0K+wCZQ91px5Jrfv/6NMc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aAEypfnmfI861w1Qoa49OZi+UvHGdYIp9apaVap+hcDpH0gFZ74o69jBpGDyRjot/
	 nRA++3KikaPR7N7GjiwUWWT3VUwOjp/+qrdQ5wmfz1rG/QnbZE5wegSJjesQtoCN+w
	 De8ZFQ/vwMmWDpAXn5AcelIjgZDK+NnbbYQaj4eyRzo14JfxBBrRfbS96JKuMx87sm
	 Diz56FWcjS4Igc3uUENCCkEY+F0xHlvJrvDB4J4unrJSnhwvN/uRbOPoegWfv8BvZg
	 DZC7dso02/CEtXEle4nZacWVPrLYpAcFuYm1RT3Uiz9hY0AWX7ICJOmQotJc2is+D3
	 hFBRIktYhDBsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 909B880D56;
	Mon,  9 Nov 2026 16:08:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B8E0111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D78840298
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:08:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N7OJvNTOtH7L for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 16:08:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6A83240087
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.250.0.168
X-Greylist: delayed 335 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 09 Nov 2026 16:08:09 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=baodeep.com
Authentication-Results: smtp2.osuosl.org;
 dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=baodeep.com header.i=@baodeep.com header.a=rsa-sha256
 header.s=dkim header.b=DqiB4M36
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.250.0.168;
 helo=mx.adeep.su; envelope-from=v@baodeep.com; receiver=<UNKNOWN> 
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A83240087
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:08:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1436A33EC8; Mon, 09 Nov 2026 19:02:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baodeep.com; s=dkim;
 t=1794240150; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=0+TsU8RcF40B0MjbzqTGoI0K+wCZQ91px5Jrfv/6NMc=;
 b=DqiB4M36AXezp8KRlHEcGwYwSXcFERlIcXq8ycKoCTOlgvg6WX4BY6eYW+Q8IHKjHW2a5p
 +ajW3wLfRfj2/pgO2wZUKtl82oFsJhnrA3urdFw/KDk5FQfndNmpVUODgR7YG4lz665Eff
 z8iRcWm/EBC8J7GbB6m/0iemBHd1Bj87jqSteJrSlBSFQaiB8/JtKBIBXEZeCH37yhRpy0
 ose+fgdKRLt76fKRCLftc0AQmKlGWrU4TJOPu53a+CiaIryV3tCFhCh9v7UKF7Qc1P+h5I
 obRi8Arg+2wI4js0eHzGc04deuYn22+nViD6S2Hr1B9mcdnImX/an7ePPScC5w==
Message-ID: <1478d4f1-e07a-4abe-b539-c8c703a9e05a@baodeep.com>
Date: Mon, 9 Nov 2026 19:02:12 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: board/amlogic: jethub-j80: update shop link to
 .com
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Viacheslav Bocharov <v@baodeep.com>
References: <20261109-linkcheck-follow-up-v1-0-64ee7d115a6c@cherry.de>
 <20261109-linkcheck-follow-up-v1-2-64ee7d115a6c@cherry.de>
Content-Language: ru
From: Viacheslav <v@baodeep.com>
In-Reply-To: <20261109-linkcheck-follow-up-v1-2-64ee7d115a6c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



09.11.2026 17:43, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Use .com domain as suggested by Viacheslav.
> 
> Fixes: 1a33ee41ecd2 ("doc: board/amlogic: jethub-j80: use redirect link directly")
> Suggested-by: Viacheslav Bocharov <v@baodeep.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/board/amlogic/jethub-j80.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/board/amlogic/jethub-j80.rst b/doc/board/amlogic/jethub-j80.rst
> index c3800f9588aa..2e8b9a5dddb8 100644
> --- a/doc/board/amlogic/jethub-j80.rst
> +++ b/doc/board/amlogic/jethub-j80.rst
> @@ -3,7 +3,7 @@
>   U-Boot for JetHub J80 (S905W)
>   =============================
>   
> -JetHome Jethub H1 (https://jethome.ru/h1/?variation_id=56) is a home automation controller device
> +JetHome Jethub H1 (https://jethome.com/h1) is a home automation controller device
>   manufactured by JetHome with the following specifications:
>   
>    - Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz
> 

Reviewed-by: Viacheslav Bocharov <v@baodeep.com>

Thanks,
Viacheslav

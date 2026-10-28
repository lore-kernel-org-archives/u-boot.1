Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C074606A31E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hy4uDRsr;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=MCnkevwa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23AF56070C;
	Wed, 28 Oct 2026 22:50:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ud15xusV0jPr; Wed, 28 Oct 2026 22:50:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CEA1B6070D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793227831;
	b=e9+E0NxPfRekakC8A/RihUMoQpGkmdrHCibBnWYqvBbAktXhsEK93T2t3zMZQYjVtw8W
	 z1x9kg6Z5ap4UmphNOfuAqEJoarQxEWI+HK27UIdh6fjWVL9BdH9sDiO5epUoE/VpBXrt
	 fAlbwd0ujkAz+XhAeYVjbJ49pZ2bv4qKXZ0p17XfsyP5qSzxgpsxHjkb+Hu3RkE/NmtIy
	 E/p7S3j7V8Cmp41uLQDP90RZwZ+Wyp+0QMLvSQjMAvmg48gzCqzK6X8mEtKiJWYYXmQrd
	 R0BZ1avTFpPa1HKpYQU3YNfH/qJtCfGdZg4kxuFaFh7kUdYZf7xkGeAEQojl18G+0xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793227831;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jopaZLmHLi76kzusApIzUm3H2qggmVV1CIgiW5ZA+3Y=;
	b=tCIRWo4fAabaIcXudYvvpyuYZr+2BAtMaEVWcU5UIO4ekTZkMH47dZT9O+4JAsksV+/X
	 aL+biY4L1g1Ow+UfNLiiau/gRVp+sLo91e/aFQcRe+Wu+kGEC91md9WGPkpC6l1v3dFQS
	 Xtisv37lrvgFNwIK/BLKQ4LCHNAt0MfVR/CUOh7Y/Pjm79yBGA96rc5nTmByvpfmjOMbv
	 YiLASQNfobUfjiLvLPedeDoEl7QXRSVADSWF9XH1T1Ke/MSR+qQZ+tCzTgFvyshQL8pYz
	 UkGno25N/CvcnUl7WdhdKGNJtD4g/vyfXIIMVxKDQZCKIseIf70Oh6sKIIYhWA0XiHw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793227830;
	bh=jopaZLmHLi76kzusApIzUm3H2qggmVV1CIgiW5ZA+3Y=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hy4uDRsr9av20KhanVayUcN1PmyzuuvcNHr3fFjvGrGVBalIQxD69hb3fBSHYpCHf
	 Qi6Udm9d9n8kH5EK3fWxpjhAvoLcpXIVJaicpKzvaWmNOQiYSuAsSlCcw+UagHgKTx
	 aB8io3PQrDMUvxWvYTl23f62ZUdMs75ldJvs78O/OZDGrgh7+ABRWCm28otE+aCR8o
	 r37xEQGaFXsg6pUtuPcrZaf19ha4qkK7XQMfI8LOvkWeu/7fOfHWpNSi1JjwTaHuGl
	 7mJP/xISfyhGzFoPjy5JFxSU8zbO/aqehOQDYrHhUhEEqhc85v9erTX7QuHI/lnq3e
	 6WCQ51CyC+Egg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEA1B6070D;
	Wed, 28 Oct 2026 22:50:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E9C02E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3452D400B5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5es1QF3KgNMW for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 22:50:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1163A4004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793227827;
 b=WbSBf9tdJBU9vl+jvY4KTPOejX8gTjc67V4px6v9WyDwB2FBVcVjozpOtNUOUpNjO8PK
 18o+pQtzje2YfrKZomOD8T+jIEtqSEnRAa0anlKuNIR8pyLUYDYMFgZOd4zV6QrxDtryg
 Dn0XBEfpiMtRALibbkUpyPt/jfPNdpExyXNOFaz94oSS162m3ncVa5FR4QVCrI76gCKRn
 NTlWrUWp+pFqcCsvlvGCQI/Nb0HogP3zl8SRot932lvFrN3oFxTQEimfVHA0KFq/iyXwR
 jyj55c9vK+wg7bPcnp/gsgHuhLPscRcm7pVZ9x9VzCqXoQA8AesGZTK9BpBE5jvGjYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793227827;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=jopaZLmHLi76kzusApIzUm3H2qggmVV1CIgiW5ZA+3Y=;
 b=j/u0rsYQHEgvFaRNrFq+MQEubyfl8cTlpgsIpoE9/ZiOa2b3Zpk1FdQ0mZjxI3VgA1dW
 Yh6Ra6JiwbCK2AasYfxlQS1Hucr1cjmxCRv8FwQp20OXyOi3fzHMlUAOJgCsuChEwVf3I
 Et5a/1YvJzEI/qox3K3BkDyIto1WqsusBG7OMxydPDeDINIK7vmH8DoJEhu9hGtt5p3xI
 wO+ELqEHbY3P2rHN0E/Uea/5rPVebydl3KS/LhFxcMHGw1hFYflFmJXTEc1tj6QRllytu
 dMTlW9IqGm3Q8zSCH1wtnS2giN5k8Ujihu7ykWsGwkH09RzjtwDkUzL4gaAHdiQjTOQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=MCnkevwa; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=MCnkevwa
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1163A4004A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793227814;
 bh=jopaZLmHLi76kzusApIzUm3H2qggmVV1CIgiW5ZA+3Y=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=MCnkevwavu3Q8lev0UWUaveWF1UbXeH4A1ab1TAmHdeATcIiHNmK3dshCyhdWU64S
 S7Iuft4LSduOQsFgEdPRtOoC8wvD7JqbQqPWKzBKHBWaQFdKQz/HYDRzBiQK+dPlHJ
 By+bKVKJZeo7MWUOEjpgIwB53+IkHfexenagelC9SgeFtbiX1nd8wHM8a/YUhwtR99
 xxlAbDNKhIERJTTsoeBbAkq2o/+9S1Vu7huXdDwRVnqJ2Fmhy2u6fIh1BUnfzz35BC
 BQxG0e9p+lnPOI6phLKSPThBvOEpyYQcA4vQApsfppqYk41qMAkw4kbZFyp09CQ0lZ
 W2yYn0PvM+SXA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 82699B220343;
 Wed, 28 Oct 2026 23:50:13 +0100 (CET)
Message-ID: <bbb802bf-3569-4555-a323-fdcd30dc927c@freeshell.de>
Date: Wed, 28 Oct 2026 15:50:04 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: E Shattow <e@freeshell.de>
Subject: Re: [PATCH] doc: develop/sending_patches: add tips for series
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>
References: <20261028-doc-sending-patches-v1-1-66b0f1b276de@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028-doc-sending-patches-v1-1-66b0f1b276de@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ralph,

On 10/28/26 12:13, Ralph Siemsen wrote:
> Related patches can be grouped into a "patch series". Add some tips on
> how to decide how much belongs into a "patch series".
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>  doc/develop/sending_patches.rst | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
> index b4f82eb18e1..b6c2a865928 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -184,6 +184,38 @@ General Patch Submission Rules
>    cases, you did something wrong if your patch exceeds this limit. Think again
>    if you should not split it into separate logical parts.
>  
> +Tips for creating patch series
> +------------------------------
> +
> +A series of related patches can be sent as a "patch series", as described
> +above. Individual patches should be small and self contained. Likewise,
> +this also applies to each "patch series". Keep the following in mind:
> +
> +* large series are harder to review. Maintainers are busy and may postpone
> +  large reviews, whereas smaller reviews can be "squeezed in" more easily
> +
> +* tools like ``b4`` and ``patman`` will collect reviewers for each patch,
> +  but then send the entire series to all reviewers found. This is not ideal
> +  since it floods maintainers with patches they might not care about.
> +
> +A better approach is to break up a large series into smaller sub-series,
> +for example by subsystem (clock, pinctrl, reset, etc.). This allows better
> +targeting of only the relevant reviewers for each sub-series.
> +
> +Of course there are sometimes cases where a large patch series is okay:
> +
> +* when the changes are all in a specific area: for example when fixing a bug
> +  in a driver, but also doing some refactoring or cleanup in the same code
> +
> +* when there are unavoidable dependencies between patches: keeping them
> +  together avoids having to explain how multiple series are dependent
> +
> +In a nutshell, the goal should be to break up changes into smaller pieces,
> +so the change can be more easily understood by reviewers. Combining multiple
> +patches into a series makes sense as a way of grouping related changes, but
> +if this results in a very large number of reviewers (eg. 25 or more) then
> +the series should probably be split into smaller sub pieces.
> +
>  Attributing Code, Copyrights, Signing
>  -------------------------------------
>  
> 
> ---
> base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
> change-id: 20261028-doc-sending-patches-d3a464feff98
> 
> Best regards,
> --  
> Ralph Siemsen <ralph.siemsen@linaro.org>
> 

I would substitute "nutshell" and "squeezed in" with something less
likely to confuse non-native English language contributors; ("In
summary, the goal...") ("reviews of a focused feature or concepts
supporting one idea is less demanding of a busy maintainer than a
collection of many smaller unrelated changes with no common idea").

with that, however you want to proceed it is already an improvement to
have the question illustrated of "what should I think about when
organizing a patch set?"

Reviewed-by: E Shattow <e@freeshell.de>

Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A065606A321
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NYtFpm8w;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=km+x1gPT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08FD44076D;
	Mon, 23 Nov 2026 23:37:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2uxZMFqEShLD; Mon, 23 Nov 2026 23:37:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4ED774076B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795477043;
	b=DxzU+67kmmBdrp8/i+9eTe/aRGkkmIEfvU2iW8GjzbYEnl2bzNBiN+MpXpVEgyFJfH3S
	 FlwU7GVbLLXSb4yN7YJuBAzOzGHxS2yNLPpziB20VBKqlD3FC90O3sXMjYXVvR0TyekGu
	 a8+WE7XtMJ199CE6fw7UcroYhQotvicuSuW5u0vp/0B1D+jxleFFVt9RIBcFWvl6ciAlG
	 Umx/zAsBeVVk/NxcGu9JZaFh+9fyEnSV/DZECIDSRdKfDFnc0hzijsUzUwy9W9f7t4qxK
	 wB/0UIR59YS8xgJAPonq81a/ECStsVaVKW2JSdp045tH+3E1fgUWRSzyKjjmbwx86sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795477043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zWmu64mtWkYPwauA4LuARWR0aPfAMqWOjO3pAMFXIMs=;
	b=UAgqLlLiga7o0uKb+csmP6nQ+fqn9LH01MfaiWW7Kzs1kUlDYi1ksilJFYgRkeCjEy3A
	 6WNSJY0YQZLccC+ZUYKOMXl1g7gYiin3VXjImIEz0Fvie+r63S6m+Ke/okH5k8iP0gU+q
	 fRYU0dBDflRyVPw78bbLxzQw+jID6IFNHRj4/o2EQVaNazc9EQw7c+//MNqb4qBpJExzW
	 9RotV9ECapH4QSqT/k4NKb+C3YEaW6QlJo/zq4zmfM0QtkDUkZCVkuklyY/1J+Fq3zFZd
	 CWOxMKe6CwpHNwusWSrrWNf6CtWHXtFunmr8IVEcKNgna59SlAJEhNn3nyJI+jJhb7Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795477043;
	bh=zWmu64mtWkYPwauA4LuARWR0aPfAMqWOjO3pAMFXIMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NYtFpm8wISGM59ud1oorPd69+MzZ6sCJInBe2NONe7xeAUc9m3Ql02unNrERld1Ai
	 Bn0cRHmKdIwgWFqHly61n05LmQ8DEv5lcgjdTRIaqSJoqIoehsPVCowGkQ74CNEavu
	 L4JHsvvitT2YPoa1g9zFVxmdYM6M2MJ1QokbCIoCfrv1tnuerTwJ6RSOofd5k8jSGH
	 fya6rrZgLOcdwbriMqTTbN4jzUMmfHWrWipQjLG5/YRWu48c+io/T8gODMQaTdEGc9
	 0aznGciiov9PKPnSTIDV6q9v74AEoqjRDe+P3u7adaHsICZZTZtMjy+HfZJSki8zCE
	 XysemhuLip6SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4ED774076B;
	Mon, 23 Nov 2026 23:37:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AE2573A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A045F605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:37:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6MyYiygh_1A6 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 23:37:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9759A60660
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=km+x1gPT
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9759A60660
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:37:17 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jYMmV2HJCzMlsT;
 Tue, 24 Nov 2026 00:37:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795477034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWmu64mtWkYPwauA4LuARWR0aPfAMqWOjO3pAMFXIMs=;
 b=km+x1gPT0CJKnyIQFANNMHa3DWT6ICS56PuOO6dM+k0sEASkQI0QflYj+rtMzcXrd6k1bJ
 ZXVzckAisEEaJO289vXO6MrRL1zENzbj1+0UJMTstTtcsp3vuasek21tm9KtWd2RGLbkdo
 rLVnsEEVrQXXTCMT1KMjq2clMUizbUIsjMO6uaoZPMAo00L5GLem4L1rnblXXMLyULUTE5
 qtzeowljCuQ1SSahlHw5vsgTZu65WGf8f0G/XlmuusYSVg/qzu19/sZlBoALcrs+nHYgKh
 zupbEkWfP2DqXpiImO3Thctcj8mFghX6hWofNLtjSWD+/milSqUWCm3oQ0wnZQ==
Message-ID: <55dd0a77-5315-416f-bbe8-e952a03d874f@mailbox.org>
Date: Mon, 23 Nov 2026 23:18:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: wget: honor httpdstp for legacy arguments with lwIP
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20261123-submit-lwip-wget-httpdstp-v1-v1-1-e1759174ab9a@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261123-submit-lwip-wget-httpdstp-v1-v1-1-e1759174ab9a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: uobfms1ynif676a6k9hayn57ey68d8xi
X-MBO-RS-ID: 1600c065ed921092604
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 11:13 PM, James Hilliard wrote:
> The ADI boot scripts set httpdstp to 8000 and use wget to fetch
> ${serverip}:/fitImage. With lwIP, wget still connects to port 80
> because it omits the configured port when building the URL.
> 
> Use httpdstp as the default port for [host:]path. Preserve a port
> already present in the configured server address. Pass HTTP and HTTPS
> arguments unchanged to the URL parser so an unsupported spelling is not
> reinterpreted as an HTTP request to a different host.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Do we actually want to keep perpetuating this legacy behavior or do we 
want to leave this behind and not complicate new code ?

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FD5C79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 12:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89E8D606B3;
	Mon,  7 Sep 2026 12:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V3ZvrbX8IJrh; Mon,  7 Sep 2026 12:09:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A2B4E60693
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788782985;
	b=f2LMOCNxWpmPIX8i8eFhjhU3WOClzhT0nfpcsByEDGh4UhnCWr7RYcEhfayOpDaqbQku
	 Own4k3ZdF40Rxem8sfx9lB0dJi5mylebfTxZB3Y70YqaUUesYY7PTNfZDSyS5alxgqOyb
	 +9A1fVjRtIYyGaJ8m85fXsrOfl+mlbFx+2yCqZDIoU/YCnzBWhq4MXX3+U950gRvxoYHt
	 xmREyYLVBHFCXXM78gTreDVrRic9WSQhMnjsJ+rL4tnpt4Ed5iDoBp/i3qNCjTrYL1bvT
	 fw1cs+5ghUG2BCiiCmw6skXo9ix6q+7jeh5LoUpnQ+uWbjeDc/bfaRZrj74RbcV4l8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788782985;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+5Q6XQvvVe4googP4KKs9rb8mrJgnyhwM0erInUkInU=;
	b=XvKblgweD8iXHpgl/wpWh8+TIAaySBv801xivIiyaWZPSzEbX/H84W7MH7EewnOzHvr3
	 ypunT8fcU8Kc1Fau3s7d8di1o1QIYWQUrQQDGXbdShTuv19BEZ9qObTvFKFgKVGoCg/hr
	 0nle7R7XrSmOnZ+Wup/V3RyCM2KnCwPYj7/v1oOD4NlYdTDMf1G8ztZqPOnT8bBci2A3x
	 ViHa1196a7ZClp390P1vJ6PTCS4W+ytp3yxRGF/O8lmCMbQvfaJr/tV1u/ypORYhJ14mr
	 j958HARJhw4EPCPZ9yD/FDZuMf25+nNBpwPj3tjvHPWicbh1ryfZrbtKQUKzhG4+7kg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788782985;
	bh=+5Q6XQvvVe4googP4KKs9rb8mrJgnyhwM0erInUkInU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZAfOwZeCTeYr9Zw3muXWjBDfJ2YzYrdngSisqYkPIMp2podZ4sI/IOHr3H/E1eMeJ
	 ad6zXBZYJsWg2zvHWvBVc84XYH6t6lw413nfbLjplbHY7Rj4cQ67sa1t752cOANWLt
	 4qaRZiNS7VVAgFzKooPFVF3rClzpJ6s/iT7rU+H9Ei3RAPY/PDn3OZppEbpwpuVjnn
	 WHt8jo9py0BWaOoc5cgg1auVCp65jQ1AhBnkw8WFK0sX+hNpRsP4sD6Pu84GxzhLrz
	 GqXzFKX08SeqFwAtN3Atebuqmx2hZaqCsrD+QLcaC/BnBMnWLSzFi6BxeNG4Fdj2VZ
	 mXMYSCTXTxZpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2B4E60693;
	Mon,  7 Sep 2026 12:09:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A8B27A48
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E77780C8A
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:09:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ed1-HsClS87y for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 12:09:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A4FE380C6E
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788782983;
 b=j17HS2CXFxlzo3iuPomX8Xfk7daK96LYnR1anDd3RUmPz2XhkllaSHZfS9oP2wFnka1A
 /zGBswhsdWMpBLi9G8LgrK3VOKiczHYpybqrCsIWMMzUz+kNJTXRcTTuJ2j+stOQ8kz69
 cgc25w54QvJY7i8rCcW96Rlk7k9MOcRQtIGbqglRWqPAr5hxgMuAHO4qDqIgAV5XHTOCj
 qNmygBMNsUxdccz4FNBY6rhHO7lB5Ivq8ayV7q4aeEr9PkCG23Dm+et7JjxfKf9+xLt7F
 ViyrO2FDn4cGsIYSlEAewWIkYirEcoPGKP+A0Gl7HyjQPAgTirrPYad5q+BuwlCby1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788782983;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=+5Q6XQvvVe4googP4KKs9rb8mrJgnyhwM0erInUkInU=;
 b=VJVEy4viodlXXXGpS8wtvnmM2P8Mh3FsMA5KynjdgBUwktRgHCLYK8UqlWcn0CoD2q8U
 BYJf7H3h8DcyETj/KCG0sE/uAhp/kKE2YcVtXAP726B/KXSZM6nX/7HJVYag4zFJEWRV4
 8VEfql+6lKnYv/0TdcCeZauyMciFPYbS/yHUb6XkAxtOgjyWwY8a8uuq/+XItG6dW7Bzk
 8tcqpUXMhTSK78nXDLBzi5m0CiJ6WmpQzs1gI6IFs56w2zYIoO2b8WzqXiwDf13A6IH9T
 7wKJN8KcnOgskUq/2UNA21uNzQyTMHOHuwNA/+UdIpwp2sk3d8b8Ziuv4feEYLavZJQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RAcncz3u; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RAcncz3u
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4FE380C6E
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:09:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F05764435C;
 Mon,  7 Sep 2026 12:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4211F00ACA;
 Mon,  7 Sep 2026 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788782982;
 bh=+5Q6XQvvVe4googP4KKs9rb8mrJgnyhwM0erInUkInU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=RAcncz3uIY7mK3pb5woCxrj/8Eo1Etx/B6vyiTawiFmQBZ36+Uep8o+WzFHfWH/8S
 Q+v6mhBElFMjmhbvmkWdWmNw5PZzGsvdncHkmBbVrfApnNqf1jJNfv3AH8YyDV+VJB
 tYMqSno0ctWMq7KTu4YVh3Jqar5UPKJfnp6TXQqNsh/IkQW/FsePNQGZA2n1kPjnD1
 U8OZFMZQho9HD83XLvoMqO9o3owNpMs+2nbcM/Wx95hVVcfSEDMU6gI/8MW0RRbiiL
 GgG44On2XLmrxonxWOaWiIFHLR0lRpRBeGb9V2il3hzXqvIsajNjHLrvpJ7B27hKU9
 6IUOQ0ZRPAKgw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, Rasmus
 Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH v2 3/4] cmd: optee_rpmb: allocate large enough buffer
 when reading persistent value
In-Reply-To: <20260903212215.2331118-4-ravi@prevas.dk>
References: <20260903212215.2331118-1-ravi@prevas.dk>
 <20260903212215.2331118-4-ravi@prevas.dk>
Date: Mon, 07 Sep 2026 14:09:40 +0200
Message-ID: <877bkxtg8r.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Rasmus,

Thank you for the patch.

On Thu, Sep 03, 2026 at 23:22, Rasmus Villemoes <ravi@prevas.dk> wrote:

> It is implied by the comments in avb_ops.h and the translation of
> TEE_ERROR_STORAGE_NO_SPACE to AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE
> done in common/avb_verify.c:invoke_func() that the
> TA_AVB_CMD_READ_PERSIST_VALUE could return TEE_ERROR_STORAGE_NO_SPACE
> when the value is longer than the passed buffer size, and that
> param[1].u.memref.size would be set to the actual size, so that one
> can allocate an appropriate buffer and re-read.
>
> However, that has AFAICT never been the case; there is no mention of
> TEE_ERROR_STORAGE_NO_SPACE in the history of ta/avb/ in
> https://github.com/OP-TEE/optee_os.git, and what the code does instead
> is to return a value truncated to the given buffer size. In other
> words, not only can one not determine the correct buffer size to
> allocate, one is not even told that truncation happened.
>
> Changing the ABI of the existing TA_AVB_CMD_READ_PERSIST_VALUE method
> to return an error in the case of a too small buffer was
> rejected. Instead, a new TA_AVB_CMD_READ_PERSIST_VALUE2 method is
> implemented which does return an error in case of a too small buffer
> <https://github.com/OP-TEE/optee_os/pull/7959>.
>
> Make use of that method, thus making the <bytes> argument to
> read_pvalue redundant - continue to accept it, but only use it as a
> hint for the initial size, defaulting to 64.
>
> This obviously requires running against an updated op-tee, but as the
> optee_rpmb command so far has not been usable programmatically (the
> values read are only printed to the console), no existing boot logic
> can have been relying on this command.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>


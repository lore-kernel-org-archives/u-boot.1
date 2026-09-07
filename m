Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71495C79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 12:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0402E606BA;
	Mon,  7 Sep 2026 12:05:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1UpNMZfWber5; Mon,  7 Sep 2026 12:05:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0C811605F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788782719;
	b=ACPs7mUX9DHPvusSzqQboDtr8ZP1dG+MhfzNO/mJrCV2PD3ULnKmbhDrz3QFHRoqf6je
	 J2KxXLQXYc5gLNzvWnvRCRKWRZ+talFfQb9WqC/KbclkaMTF9qPyZ1KTGUIKV64qsPuzn
	 ri3D9NKIh7ZcM0al9mRgeahmUso0vaQlj7rHxLHVbKURHj4yrNc+oOvD9jKzmfV2en8Yw
	 DhA7/hw92bCS0A27F+oHjdNC78/FRvM6VMFJPd/eFP8xiopzqQ7gJPTVpLV7yTHE1MmNg
	 0jSvG9noyjUkI8G2srnxkfB4lafQXLMlZ7kM2p7f4/I1ulhiLRAFC7qFmYjCmKjGLdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788782719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uz3I2KyeLKA6sVIjEBBSI5SgmAoi1vSCg5MhMnbDlH4=;
	b=ZCXnqbnrdHAeKCn/rwDNTitPUr0ayZVJha/ZPrlk1Tme9UwM0/OEB7AW9YaangDTUXrh
	 TfXKJsjpjVfH10drDFJIgLbuflxe78NzlcEvxxQHxLXQu3Vo4aqvHK4Ctd46RdT5rZbv1
	 tnErIsL0qb8ZnC0IbnSszMvFx0rcuOZHy+ZMwumV2u6ulcRLubhR5aN8pKfcoSsj5ToRU
	 CxWK86vv2I7nM5nZ49ACCT8gTElkFRMhZF+4gUTnOoB7agyS6jjfew+kgNcc4h3a1Dhm/
	 Vn6x5C20chMfXx+eoDSqsCbwYwQmHRqLl28yGpKop1NoCxh4eUMnXStlgpsayDudv/Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788782719;
	bh=uz3I2KyeLKA6sVIjEBBSI5SgmAoi1vSCg5MhMnbDlH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tLiWc5/Q3p7jh2qe9ZHeqxcWLMK6E9dTFy6fjVrB0iQY3AuJ/reerUEIyuMepICqY
	 CUzCZClOnY29OWDhT6DPLQ4RTyDR8/F3jrMBnZ3qFaSkOGQaKF6329H1tg5c8MnBaw
	 MPcy8Jc5fUNTU+Ac9XdNqPF0cTL6AOUXtXmurKlsJ87SSoDCDAx4mDokgxWAtkLqZi
	 dbXjDIQ0gNzDMQSloP2HpHoke3CwjA0MLLX3gy4Q2cMrzZL468+RW7oaEN468C+Wfe
	 aiVj9ByWbV1BvT6LoJdz0TmsVps793KDWkJpCRaSMQm5xiIjYQ1im2p2+yLRd5xv5F
	 a7muqfuZOj1GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C811605F5;
	Mon,  7 Sep 2026 12:05:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D688134E
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C85B240105
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:05:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tjUCVnUyH9UK for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 12:05:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D214440103
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788782716;
 b=dvNjGcPH4Q4b5L0uHBihUApAWJEm2+gV5u7ohGtKFUH9TKdhhAySfcPrRu1UCeONaxrn
 rM5QmiVEsE6Ii0BwhuiBYavvJGYhrmQ3KmvM/UUjG2eUB6YUW7yACTAaZDm3gPJ1Ri7dx
 4qqhVAhBKeTB1gifSIr3Ui9K8WY8D++5UvDNhgvwz/y2YYxw2UkHci0XX+nXKQzcbyo+f
 2MvcxPQZlAlzGx209zYdYvd7D6N/O3TrhMnPW47fhWSVpAQAunPbnZPqBHPQtAQBj5Le8
 /JwGWJ2Y5bZidOIzDtAQ8i8lt7Qac/u7hHV19fTyzsUnWvVcBji0q90Pt8r5LA+kblw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788782716;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=uz3I2KyeLKA6sVIjEBBSI5SgmAoi1vSCg5MhMnbDlH4=;
 b=odOiXQJVuF2rHOxaW63alEc1ivwFS2FBE/PXqn1nmPjVi5u/ce2LiksdWznSz70A8kpj
 pHAD5nwTZKDWDH0nUFt/l/ebTBmFBx51wwX6fTRqcV8dLe1fyMla8H0+xLps4eLTfbkuk
 MnUcpMGlavaKXimWODWKJXUKC7Z9VfYigJUGzTFrS8pNHqwFbzFcPXzesI+XRUpUMU9rW
 kEmAy7bq70100LdKrs5RPNLGdTCbhQdZW1teclRsNbmHyOjUCPqKdRF8H4jhT8nDxD699
 Zu+GfLqyfnwLe1uPe0nFIqZ5u2p99o/DX11CJLmP+zsjqoeQXnLzE0lRpbB03DXaGNg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="Hex/lB1d"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Hex/lB1d
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D214440103
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:05:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A9FD41FA5;
 Mon,  7 Sep 2026 12:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774F31F00A3A;
 Mon,  7 Sep 2026 12:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788782714;
 bh=uz3I2KyeLKA6sVIjEBBSI5SgmAoi1vSCg5MhMnbDlH4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Hex/lB1dua1XU6S9jGpFxYWjywgDzzgwcf/HMjCuHqs7xRqe8of3R9zds85jzRH5a
 EwBCu/GRhbj5M0xtDhtFm3L4A0eioqFubfA48z9qqIL02Is4BHpRcyoO0Xuh+m2hij
 cYJbqKveQegMzPw9HBug+IC4qw+SVXw6RzhRqv9xmfY5NVZ/ymRUVOtZE4wRAjMnXn
 rsDfVucdyjqeOhN+xloJicwC1hvXU/27nMOEj3i7wWLK4ICtH3NgSZLpb0PY8TWssz
 yTp0jvdAoseCy5oCJ0Y7mXOXlpXE8vT9FJh8bI/OdmRPOjyc4f+STbWhvDt2+sWu5s
 /u/N8L3zJdLaw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, Rasmus
 Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH v2 1/4] cmd: optee_rpmb: sanitize TEE_ERROR -> E*
 translations
In-Reply-To: <20260903212215.2331118-2-ravi@prevas.dk>
References: <20260903212215.2331118-1-ravi@prevas.dk>
 <20260903212215.2331118-2-ravi@prevas.dk>
Date: Mon, 07 Sep 2026 14:05:11 +0200
Message-ID: <87cxuptgg8.fsf@kernel.org>
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

> Do not translate both OUT_OF_MEMORY and STORAGE_NO_SPACE to -ENOSPC;
> we have -ENOMEM which is more fitting for the former. OTOH, a new
> addition to op-tee returns TEE_ERROR_SHORT_BUFFER in case the provided
> buffer is too small to hold the result, so also use -ENOSPC for that.
>
> Similarly, -ENOENT is a better match for ITEM_NOT_FOUND than "some IO
> went wrong".
>
> None of the callers currently care about the actual error code, so
> this makes no functional change, but we will add special handling of
> the -ENOSPC in a later patch.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>



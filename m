Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753BBC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 19:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3381440730;
	Tue,  4 Aug 2026 19:22:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Akn-y519jFNB; Tue,  4 Aug 2026 19:22:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E719C406D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785871341;
	bh=RRznlpkbjuUZooV6H/p9gsVWMm5B8pjK3glErI0IKmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PfrSkFaL9fhHmmfHqgOGD4fsa5D1oFHvA0a/V7RyVaQaDsm/aa3zPZm2G9fWJvs8g
	 0LytgBZUyc4Jeza81AeKmpLB4ie6DI6C0vztrvm58hezJrvc6G97QWUhxQTOYs7qng
	 0ZYCheIyOdsGu0Y77TnDY/E7QO4F9S50K+2G/LBWMS5RXhj7jVnQAi1bj2ma0/A88K
	 879EgVrHal/bJ2fOZdu/hx+R+j8H8mxCr1PHP1RO4wPKrgsYhkLOGcZ295Ca3qvcoc
	 IrBJIA0O9Nj/ijwS3xRjVExvxSP+PWImrvYQx/bxznJvpKvVRDguQfAL4P/fGNl+c4
	 enAk6ba7X+p4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E719C406D8;
	Tue,  4 Aug 2026 19:22:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC6D92B6
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E6BC401CD
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6REP5sllxba for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 19:22:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A6037401D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6037401D4
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6037401D4
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:22:18 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a14f762de4so215499a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 12:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785871337; cv=none;
 d=google.com; s=arc-20260327;
 b=dLqfJSTvMEbIWQSKNGfGKEslwYMfa0GN8HfUbRP4neAXWVk7Ip6I7WSfvnLsY1tTqx
 FMoDQlHLdD4Gg3v6EusKp/0nVmleesOUALvQMRDB4oy7pBNwivIUKEkpkWNuF3CnlA/B
 j3liRjOP0WtGQO5RanI0bi7WnJr9rKW3GplaLWlYRXcQKqa+aJNxvuLgBfqMGcCi6SIu
 CS7rc6edIXFiJ+MdJ38hWfCBFrLlFrDowkY2VOHSDtJtXBXl60eA2BvIniV2j0A17A5e
 JBHFKtmR0sjl3l/NkNVlFZUd2XAjil9Bsqxkxm6AbqaNsYjJeoFSF+bQhTrUybws0tD2
 7M4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RRznlpkbjuUZooV6H/p9gsVWMm5B8pjK3glErI0IKmo=;
 fh=LpCD47bnO8lqVAYEo2Kayy0sFPWyUoMN6ZkoIu/UCgk=;
 b=XCSoljOawVb3pErkqSkVxdfhl9O9VQhd7CPRE8K0Wmt0N4uVtBnO3Hg0xiebNng/Qi
 FJNoyCOhhd8TBIHNMyoIhHQPCG7q9yFvcj5ZC+tWe2G2rnc3xcClO93ghrbP6LZycguf
 OAFinkwefgShJqC7PKVwxhEcuvfliMHjg63c7aszENLCoCXnkw3VBFEVki3q2x/wqFlj
 ewKL+zcA0C6RZzQB5zeVbksGzazG97RZRumk93NrYVJdDkFg0KoY/V+ZnCpKCtONzkqw
 zzRq/KpiqLMDVHuR6OIdZw7sAv2ODZ6uzBzDaIKUoeDHNLpkZH+TRoI1aXDold9yCVYs
 xCeA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785871336; x=1786476136;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RRznlpkbjuUZooV6H/p9gsVWMm5B8pjK3glErI0IKmo=;
 b=b1Lpb/h7MjKRNJga4zPwwqxdw8ANA4j7HpUV/9Hqu2KTpmY4lRZYZ+A9qQ1LHE4ln0
 yRt9ekm22Yv97lf2isymL178HU+D+WmQu47W3QpbPR6/bppuhxFgu6LzUaIP97YWdvsm
 KZpInOj1AJsApqGs2vdWcg+OBifHdwoBgxVrjtgyMy//V9P0w6CxuWIckOst44LeP0Bw
 fogmu87ElCQm+zwZQHhQ8ZaPBmA7LRB7uHiGfmNS0timR4IapmyEwcNRblNIGmZZnU+P
 j5z4L165vjUdhuK0sknzXaAkrznmfoz5ZnHP5YKW+xUU81q/NUPf2qcNnnQdzNYd1Ree
 sS6g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrW6BjYMjJsyYg+BxyLjx6UtbyonG8HnNk3q/b6rD8oTnyfKWa0bPWAGgR+C/omuUuGDBledTA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwM2ceUio8hVtzqGb/IlBC2j9n/awuVzoiCLZ2t/WZN2/AhdnmJ
 B4ueP03Mt5T+B+yAV1D8/hwisML9elRMytnzhQFfjnEXVmJJrjgcMUa5jbZCKm8hR3M5pGprQSC
 9mZA5zaTb2TjGFWok5/CDhMVLErb3prVvu6JBKvFQ
X-Gm-Gg: AR+sD13xz9U4z23gl4GI8z5OIkbK2kA9bEUKm5e9sm/Q+Viu+TEUE1wF5M6/HsgAy94
 wrb+VLuXclq7qcfQu2Z54tBqqLfvJAhZ3ym6CoCoWOf3k/owaOFw85jXbpacc2h543LEKODdo1Q
 P5B/PWCJr8LrNRFKwPjmwm9jTyQGwMwUGASIxut4uPfacskafRJRHP0QnheGNRwzLUDUR/i31Oh
 kZ9UNpkLtq6nrOi3rV4miDUQpO2Ca8elG332vnN/2yJjddWX8U5b3JGYNKhOd0RKwNl08ruqfOn
 vajQaznozgZQGI30whrDgt+heWanZlrrJ7GDj9y1VxI=
X-Received: by 2002:a05:6402:380a:b0:6a1:1e25:143e with SMTP id
 4fb4d7f45d1cf-6a14f07aa0emr757331a12.3.1785871336672; Tue, 04 Aug 2026
 12:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <02ea1132-9adb-4f07-b14f-9648a61a8021@softathome.com>
In-Reply-To: <02ea1132-9adb-4f07-b14f-9648a61a8021@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 13:22:04 -0600
X-Gm-Features: AUfX_myE-tibvhkrZPQjaXpq1EbKMA22Xhv8bEMR_C-CtLMDgI56bfjbzBVJGrk
Message-ID: <CAFLszTj1NG2jLgjrfng-iBmLepgxV+Nmwotm1TBEgCT_NDJgJQ@mail.gmail.com>
Subject: Re: merge software ecdsa support
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785871336; x=1786476136;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RRznlpkbjuUZooV6H/p9gsVWMm5B8pjK3glErI0IKmo=;
 b=lfvUcBCVuSuNmU/S6uHnzFqXSkb4xr+jFQy9ndCrM97YgfvHAQt69ITpZteNj5XwEI
 WEoLiP0PR2AB+udz9DDgocUp21VB2kpGEmmwcqZVAbjmTUBPE/DFklQfNLN7Iq+231Os
 75ricoLIf1iqj5fx5QSaznPdN0bhfLaq41Qqw=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=lfvUcBCV
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Philippe,

On Tue, 4 Aug 2026 at 08:29, Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Hi Tom, Simon and Raymond,
>
> Do you think the support of software ecdsa may be integrated in the next
> release 2026.10 please ?
> https://patchwork.ozlabs.org/project/uboot/cover/20260601134310.2452454-1-philippe.reynes@softathome.com/

Looks good from my side - I think it is waiting on Raymond to do a PR.

Regards,
Simon

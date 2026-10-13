Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55731CC6B09
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 03:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F1426066F;
	Tue, 13 Oct 2026 03:37:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7wubOMYH8OHk; Tue, 13 Oct 2026 03:37:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3809606A7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862646;
	b=XfJEo2D/sPzIvDv9/kwDpKoTxSBQQL5t+d2Bl/iCJ0j3HNAEe4eK6pkOSQrfIc6CfP94
	 L+gLI5M7U0ndl30engAzP6ywv+zl5LOkNJm3oQb1oA1dK1dAWGkikprJBTHs/a8yaQ3/X
	 wUyh7xgNIDi0pb3HQ+RIqJqLSpUk+P/7BuTQopcsUZlVejcYyDw7U3tPkoqPFO6FjyuLO
	 i8Q6W6X1KzXB7R3emVucgc94eErh7YsaMGtyqur/nJNHhJEzFxjZDouYKhku2n8Ps5qfz
	 pYpef3b/4KEU8P5FJkQPbq/bl1imke7IYQV3Z2kR/BU1AHVkS9/9VSeZJ5TkOgIqfVA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791862646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qLzuJ/sJ/zlaD9S+mPNemyOXBthSgeIM9WPueYAk3jg=;
	b=RUF9+RVuDsWPtbedC/6v7UbtnJ0t8i46LkWTuMhHc54g1QxyCPe2whqbds7ZflpEYoG3
	 djj2VFsl7ufRPPnPqOR6fIU5JsIXJuh4Z7B/hHLpJ4RmdzRQ54nHo/1BmZrvF7k1oFgBW
	 PH3Vx846x/khajaWyIEon/VEYgXp5y3SQPiUQkyy5GcyyWogl3qFHGIDiaiBbph84jjIF
	 FUlmZvQAnwlCrsPDEL+21/3um+jsaUGHipCxP48eBgEJvXcpCA8T8QmpHlMvmfu7iI5ad
	 EyH8XLzrgeMDksBCJC0BaZAVM8ZPN7bZgATGDPqpbAkGXc33hidJsr4Rm21WVtZXOUw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="B3VOh/xz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791862645;
	bh=qLzuJ/sJ/zlaD9S+mPNemyOXBthSgeIM9WPueYAk3jg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WS8IqBdvxVihCvGE8+7Jb2U1H/7IDtXB5f1erxiSc4eA2coF/AIbzF/Luqpvk5RWO
	 5bcf3pQUiNiCU1TACvjMPRBblkUuUOMr0/noyhBUE8k1/eM2DpiLFf1Q8PLB9E1OXG
	 Umt6AfBFUbGOK7hwT23JDPLew3uyQA2juXI9ArOI/RuMJdgXRgfa3gO6WeK99DItOP
	 oFqClhDY+ZI6qxQY9Hhw2A3ZLPIHL4MXSKwSy7e4HNPxv72goNdoBJVWfl5qodl6YC
	 ViIHRpctXis2iTv1gBXXcpcVSrF2xwShyb2UXUpfpRmh9oX+LEWjYKjB8YaYMXSFnP
	 ZZu6nQDZp6ERQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3809606A7;
	Tue, 13 Oct 2026 03:37:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 672444DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D704606A7
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:37:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HxkbU8wcNpUr for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 03:37:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D9716066F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862643;
 b=JR5xJCCqZ6Pm6SO6Em0a8IMANLfr6JVjhCE6IlakoihpVIEo16HrQ/kqh7tt8o/6qttP
 FU5CijD9/cQ1MCavgrEspNUHSZlVgSfuJRX0M6QBUaO3bgTB4jRVSQw3jR6PyPIv+nohX
 EhL3Apx+iknw6DvN1qk4gok0RqbswdS6O38o8uGPXQ3SnXylwt1g6/Qxr9O76tKR1VgGE
 H91tgt1LkUJyt2WHh3m74AQBNPC6HCBw92kQloKBQM+P7twgppJZd3HOi2zfuScQbHkfl
 O7fcpf6yIdDVrydmhSO0MM+Qp8LacMPKnAgHAUXlFBhalzd0Sd+vvzY/ldbZdKyOT4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791862643;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=qLzuJ/sJ/zlaD9S+mPNemyOXBthSgeIM9WPueYAk3jg=;
 b=JPflKzZ1wRRUmlzxJ28RxKCTMg7SR/sRKh/SAMnRpTmzuhrKe676bC3AZopkza7YbT4L
 x9rl3JMiQxJqZULczDPT/8946MeeAeIpWdZ7wElW37fiBQiYwlkCo8LhObE+i57ypuTTc
 qGRKoxUDfzd/9Wvy1rgMTTDIyZJJpHcyKprmD7sh6Ip7SpS8IW+9ymlhFUJxvHcojMDzt
 fncj+KlUChOxHXR8ujX10cgiw2Z6he2Jc1F7J5avr1zmAipORj/FLEziJm81cyhoo/jEw
 9PgP95EeruC5L7K/p5GFL6x+ttZgvcFnWi+5PGeKdnPKvezzB25Z+bkT7OjFsimhw+w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="B3VOh/xz"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=B3VOh/xz
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D9716066F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:37:22 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6afafc89b48so3260293a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862641; cv=none;
 d=google.com; s=arc-20260327;
 b=SpGeMeokyiaLMIKb5iYRXjaIuL+y8SaCl8yEMrviSdDkov3NLbaMcmnlJKdvi7JARr
 IyVl6Itk9YgsFE+SWzK+lRO2IplIana54cR6KytsM5a96z1R0OsetiMi99xSK2lmv4c8
 hOOFVDv761VUVBRGPIOQPYEdKTGBQy1cr5PrvJQu9a3veTVhvt3zoPoQq6CTGpThNirL
 9WCrraUGdZKOtc0PAeXIDaQA8QpElys++uMiNulFffMKloRLpZPeRbI0ybM6AJQfqmTU
 Bbx57GsslWzB3HZCYDn0MhcitRzwBk2dprJgNuWYkvCyAei8F3L26zmA93KrFugsxjIQ
 5qXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qLzuJ/sJ/zlaD9S+mPNemyOXBthSgeIM9WPueYAk3jg=;
 fh=WmJoPgKjPv8Pp6sFmWKtnQ1pHd/JyiODkaxSxdkBGAQ=;
 b=S5hhfVYohB3g1TmwasRRP1egAMyIvwXM113mOH0ZthV3yjdhzYdW/sRPnr1thdJMly
 9vsIunMjd9I9OuNL/pX3/b4W6yKDlc6sRWEYsBEiI9Ns1lom+gTueScIdoMO+Ulz5no8
 bFddDgdSJVfExKua8QBbUdKOX54dSf+XPhO/WElnCGwJANG943pXWBHXqy6fzw0JNWWr
 aFT3gJ0UhjB8fasv2HFiBZHp4w3T/o6k5+VJXjp7vmh2m/qngUzAmcj0H/WAfDOFsZM5
 4HFUflDd/GzENQbF//83qavzzg9XThwfei31P2Ht6rXRtieL5ZgoCxJEbnTaypMofuzB
 SBxQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791862641; x=1792467441;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qLzuJ/sJ/zlaD9S+mPNemyOXBthSgeIM9WPueYAk3jg=;
 b=B3VOh/xzZVU22Jm2RqJrAOQhTy0eF3TajXFYX5t2PJTtrZOAMHJ8e1WZo6ZlRBTTNF
 WCiyM24vY9D+4122f6vpW9zDslDu99lpwXh1p43ranexocUwFY1vMcJxQwuFhdTPjYHo
 2ycZisvO5QLlsDOIhoQJfcK4UzVIGgI2uQXa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862641; x=1792467441;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qLzuJ/sJ/zlaD9S+mPNemyOXBthSgeIM9WPueYAk3jg=;
 b=vHtB4mfISy4jDxrv6il+EJmf5n48hnZdaT9gaOvRKSJG/wKe5fA4rTkro0sDSilJcT
 iBY3QYuIX/4QVJ+jnG4AeVdYymDL5217pSttVxdyR6sV/mOSC0DngqMEmueYXyr6hQUV
 CNciBNKcocHsu1LuBF37gQ9pgpJ7g+euyKlLLJBevuKVpKs8VFcJF6Uo8u8v+9scoGFi
 FqdQHsAhadFvxdmDW4Jrli5aY0hSCvMyn8DTgHtNEDNk1TMgjHan61q95u3eh1+mlM0f
 7BP4dSMU0WXsWfH6am+RhY36Qq0FTh5rnBWZIWY+6DmRr/jzWIomeR0w/LsPF3tyZw4V
 W/vw==
X-Forwarded-Encrypted: i=1;
 AKwUvByJ7ymUCmQpeWvknKIDUueMBTObdApH0WWTM9ARKWIm5kgSL2bcagKNxMxY9uthQHNsSsdnESE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJeXBVydhwsdGr3lywuKeRTv709UJoCrI9TpJNLEZw6ImFW2AXh
 ecaLgJF8GUN2jCPXFnuV2upEG8xzcF3oSxdLgtlEFRb0yPGNnfxnFkJIKp2x28EpyeeJscV01nU
 1pUEuDKfA1ogQp9u9fBCYZ+sUNE26EjrhbZV9cdGc
X-Gm-Gg: AYBFou11c91hgb3xMkGcGFzSsVKUmozyBL8MVBtpu56yKaaW/D1jyoJDu1lTi3LdBUA
 m1RUHwvpZ8pjt7kHGEBJ7qfwkmrqrMv9CmsaR/GUKCGgG+KogvlXkyRWKZtC3p1QaUXRK8yKZcJ
 LA3irfIYN7+v1C1Y35mLlo70H1+lxr4gx/iXOvch2kCZ36fA6uFcfvWvFaDFvAh30AeSJgkqoN0
 wsnRqIC/0bzwqyb7Z57e2TKkXhSdaumOp3B/1TlQeaXeDQqCa75MjbBuOjHzGpmPvzXdEFcun9u
 ppiU4MlzUgeRQF7Sb4v1gFqLWoKdbz0H3ihC0rgTtOj0C+gr643izQm8UkXCZXPzFuc=
X-Received: by 2002:a05:6402:24a1:b0:6ac:934e:a9ca with SMTP id
 4fb4d7f45d1cf-6b17c163361mr9153538a12.0.1791862641072; Mon, 12 Oct 2026
 20:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 04:37:06 +0100
X-Gm-Features: AclHuK852lavvUqEOZ_11Z0nkBRVxLadcgmzEsj4JoilfijlxO3NXq21ChN1QGs
Message-ID: <CAFLszTjfzpSOmjm4f2wT+V62q_PDNbkMS0t3LgWnQ8_wvxiWCQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] fs: improve change date handling
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Daniel Munic <v-dmunic@microsoft.com>, 
 Tony Dinh <mibodhi@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>, joaomarcos.costa@bootlin.com, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org, 
 linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Heinrich,

On 2026-10-12T14:00:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:

> * Let the ls command print the change date for FAT and ext4 files.

Patch 2 also cuts the gap between the size column and the name for
every filesystem that uses fs_ls_generic(). That includes squashfs and
erofs, where no date is printed. If that stays, please can you mention
it in the cover letter, since scripts or tests that match on ls output
will notice.

> * Adjust tests.

Please can you fold each test change into the patch that causes it. As
it stands, patches 2 and 3 break test_fs, test_env and test_erofs
until patches 7=E2=80=939 land, which makes the series hard to bisect. The =
new
patterns in patches 7 and 8 also match the old output, so those could
simply go at the start.

> * Correctly update the change date when writing ext4 files.

The tests only loosen the regexes so that the date is optional.
Nothing checks that the right date is printed, or that ext4write now
stores the RTC time. Sandbox has an emulated RTC whose time can be
set, so a test could write a file with fatwrite and ext4write and then
check the date that ls shows. That would cover patches 2, 3 and 5
together.

Regards,
Simon

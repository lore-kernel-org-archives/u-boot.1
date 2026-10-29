Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E208606A325
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h1McmbUl;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HIxfPs3D
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6075040754;
	Thu, 29 Oct 2026 14:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YE7TlccY7xtQ; Thu, 29 Oct 2026 14:31:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CEE67406E3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793284277;
	b=MV5f4YkVj0TgxvoqPM+PmxYlSVzxyTMYJS+QO+5BsEpfQc1/lhUkmCB8WoU5UTRz48hI
	 9VGjbNQ9f2n+NCKhM6tDczpBfDjoT0lBAiqi8rzFvQQbl1TnJfNHGkWUaWE6g+tNzHoOI
	 NJ7PNLbgsm1EfS3GbfhauvEU6BrxLeVfl7yzBG3pKj/SePrHKOeOxMMQdh1Pdy5d8bJZi
	 epa9rjBwN/xQ3vCOoi4PlIPhnEoimJUjYj1hLVIjVokH3x7AroZPMRe36JuC43WOZWwTH
	 aUeXd6xamS7W1USeSZEKjCNcluRzqX8/OTz0wBDXOwCGH63EUHXID4we48D2KSCJz7g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793284277;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EQ4+qlwuLYjYMrXpVhuAZ6EJenbTs5NDpGpPnpqedZU=;
	b=Nb41y0YfjBP3nl0GMQ4KbiHiWNiC2klr+AB3kdWVzocwsfVGMmFSCQpB31SEhIq3DO26
	 vzbJjieNg8wnQ3f/EhOCc0XHiIpxpp6dLqXjizajVpzoMUTjf8GhycJqwiW97Sd49mrsm
	 zwxJkxSpxb1vD0IuIGDT6T0v7NP60V0oJ6/K0gt/B9l49PElREuQ06QBQNSztao9qRq9w
	 OpFxXwsqzBhXH/dgo8ukCUWYlgYEh4BM3HRHuYQH7uBaC8R2AeOHG+zoc0FZ1Rkn+MqY4
	 5EQWSUhOSNXFGb7JnnDrp/nJz8R7zHvJepbbi5VtwAZOFDGTosTU1TeIThv0KtmLPGg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793284276;
	bh=EQ4+qlwuLYjYMrXpVhuAZ6EJenbTs5NDpGpPnpqedZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h1McmbUlU0mjVpOXK3xob7PcZsJcrel6rQxmw22rGAHzOhEiDKnpr9blaVMe5C/bz
	 sNvJF4R5p+qadqmQs3S0GrIQaWuDmba977ligV1azWfrbQCQuFODG+nn/7mmHbFxRX
	 2FrJoP1CGhu6ocJWprqh0Pl1nNW4vQNv3qcrXra/P9lcFzBLKsvvddAY89/qLKuDTx
	 AO4Vq/Oo/7QeJEGFaucBpGab9B8MWnXGbI6lHa5Ubq+dLrzFEGE5ICHUkj0xsTv6J9
	 qBmCh+DKgNyKZdFNZfEv+Pdgjdl/NLupTEpLIRDXblEND7KzQgjSFgUQJJsHyaq+Jx
	 BPfAT8EenH/xQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEE67406E3;
	Thu, 29 Oct 2026 14:31:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E228DD7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62753605D4
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:31:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QYlgst2CvDw8 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 14:31:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ED607606BB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793284274;
 b=WmD5aoDttEJj4rKUHFlMGa5qoJNvmNeRZbgqk0AV5moTua9c9c2Lobd1IcTAXJuOSNve
 dzvpVpTk3RwzbSfb8qIcBgBB5zecXCSjOBPyZqmReCX+gkUEphgGR0jr+pZuNr9TxlxIH
 H+YqlPcBFa23uu/+g5cH7qy+VpwlW7ZWSA3fCaolz1ir3/n9VJ8pjl3xrNyEVNkv+0r+Y
 7WHVU71ANNcqIqBaXvOAvPpa7f5e9yxLybFTZ55HQxZUvod/avbDOlZnnoy7lEYFqAJb2
 bxhAJ/Y548uIR7TFOzEpf1miz+BrOPHFkebyHao65xNINdoUyVhIV4bvR4x0ySRkkDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793284274;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=EQ4+qlwuLYjYMrXpVhuAZ6EJenbTs5NDpGpPnpqedZU=;
 b=QuwvWko/2HI7o9O8nAIDYjsTRagB7r3aMolLvow61d7G3MBrytUCNeIJIuWD9ffpWKvc
 e0Mz6Cp5znbzk5fUDXMVAvVaQ4OJq/p050Kl321eHQ5J1n0FAyFBDKYHkIemZSulFCkwu
 4ql0JVQZoJvKVsRT7gNB5DGWKzdLbEUCjGGrljIR/loVxXpPkBUyJE8K/uGX3l0D4QqBD
 3P3fHfkSoxGm1svmQ+hYeRJBdX3p8kc88+48FaJ+z54uLcnOuMhbLr0GXAE47MhbYK8k5
 VmQWBiJijUywH/nNa4vOkLTfaifLccekK5gHYFYLnkdH88j6gGiTE9maYUgnxkbJ0HQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HIxfPs3D; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HIxfPs3D
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED607606BB
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:31:13 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ab43af5e97so10046207b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793284272; cv=none;
 d=google.com; s=arc-20260327;
 b=YVON3t3a+D4Ungb4aOaWpk+dm1fP1rTgkVDAwKeAs5EwTgeOel6+JvfsI6dQthD85G
 pDr6Zor6nY3mbVS3X4oR+/SFSl2pvKwx6rv8tIoby3LitOzVmzcm0zIFMdkz8SByh95f
 831lS1EWvnqHXdEdpUsOaktIr5mbCFb28gcY/1gMW3/HBn2gP7DLYC3VMIwDutGggHTt
 6C9J0y65/mUefTQkGQEstOi4N3ukxpA4ZwAIJ88Kta3kVmMNYlAIPNHewgv+3cGTBv03
 +RGfS3D5qeXyZH2KfGwWBIbOGmvLr/fcQal6p7d9w/6QEzYUWmV5yCztYrN4UMTzfhOi
 LIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EQ4+qlwuLYjYMrXpVhuAZ6EJenbTs5NDpGpPnpqedZU=;
 fh=W8/f/M9jxjUraLqdVrNjjZeASRCwT0Jex7TG+FXiP8w=;
 b=IPE7bBcwyYXOCxdEH15V2VqvmwbaWKT8LSUW8iAbGr9fK0fbraLXoOeVBJPWPpYBT6
 2p6UT1ko4vPq4whwwVzgK/JlSygCYMZjgX1jVHd9Eow444p6H9Y324pqqJ9gmo0vqlVZ
 Fc0cBpIxnCNysvCJFd2A8+A80XvgcEm9nIPxc4cEdxCF3vRj5zMplkwYCx9wfUZ6e9sV
 hitA1ZyJXMZQmJHEKGG6LeFVrfKSPnXt6uCh/ky8oTrdOkB/taq/gD9AUqPkA45vCOkp
 UiYBVmn/kg16MF5ofmCzhPQ1oA/AKaikGcnFkZFc0JSv3ecvQi38J8Cx20xXP55wt2iV
 9Fow==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793284272; x=1793889072;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EQ4+qlwuLYjYMrXpVhuAZ6EJenbTs5NDpGpPnpqedZU=;
 b=HIxfPs3D/Q8OJB3KWCGF2GzPU30lvPR1MtpSfLkVOaSJ06k8TfFx8aFUI7SttrqiHO
 7DRr27Ews/l9Uk9VA35eu7bVMlm6fWs2HII8LdA0zFivC1U4ji40rasbQ131rAPmmW7V
 t6tICh9K1X31KbUcWc987LDLAl+ENMHZPIbiwycYaAcQKh3bA7gQguKAKbLRdK9Wv9dp
 DZmzWU1bjjss5znu0W1hHY4ZK5QwjUPywTE27hohASRXUc6JWqaWH6sIIjlbgwEPZnRG
 HdbAEevyWGmu5RIwigAlbV93OjpGzMvJnqazcclxpZbMh5aKz/ITN+lrj7+5ZYzCx1m8
 1v9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793284272; x=1793889072;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EQ4+qlwuLYjYMrXpVhuAZ6EJenbTs5NDpGpPnpqedZU=;
 b=KOpuCKtw7iLyRQTm3YENjH1eET8utwsFou3urQ1ttT1G6w9ZPIXuAFGou9/wGxDB5x
 38hdqu92ixUaP1DhLmk0X8RsUM31Zs1c2yZz7txPFgxYKLN+39AXAhHQ5atLrYCZ91K1
 X2U9lk4fYVsn8IH9f/y3qoDX3wheDcfwYN/8Wm+kJWG7owlp7rR8Kr4YutYhQDGh1VWZ
 rGFbORr+1ZrNhJTDQj5xckEsEJ1qZ0ZMGazNIplyE38ybtpqduKbG5XaJRZy0CkA9P4g
 JMxysN3zmeXiIG2r0YiF4JS1lVZnsn7mjjeFBBlTMpEi7HpykOXUoRT1PSPU7rIOPvaM
 RQ6A==
X-Gm-Message-State: AFq9FYKUToaQFE1sEyrAcUG9GQR4rIWf0isZfxOVoceBEgDWoqeSuyU/
 wq7Vw80AT37tY92bPohrK5bjTEtB3UKVvg6SZw7xIW3CLB8ctByjOBIx01yxJm2T043ysqrvs5m
 5hM92jwDOol260fKQL3ExPh324hsOW/yKahdnjTbGdg==
X-Gm-Gg: AYBFou1tboQiSO7FFRDGNyIah4KKUQLo25URjLj3SnrhzEwX5o24DmDTNsRF8gOXkqU
 XJkJOEYsndOxTiazEtkuMgD+jzB8q1xFJmgtNpAmHEDQtWbaAShlh4Zwj1P5IfT71NOd0w2YNen
 drj4P4rexU3rFg8xGJ78pWbxNNdHxvW2j1aKisPoT9yJ3LJ70DcqCm3/CKfC6+AVw7dQKMo9jyN
 68tevdKy+zmdJgoxX+KawzYQenhSTF0dZbTBnw3MnWkQmysWTpmbFY03xxmHUDokqFtWv4O5mOD
 KXcn5McWZj12Pc9pmCMalTL6sWclgNSZQn8K88Q1eZ6Odb9z3f//tiLRYhdC/olCYPUM3EI7AMO
 5HYteN8C+qQjPSt13sgjzQHlIqBdjmutdqmQNL5u5y3Bt6PWZBeATnzrZGm3oD7BHKt9WYagWMS
 FXOrzuYI0uBtwBCoNpxqImiT+bWdoPxvMzeWaImFa+E6Ipxi7G7uNrKLGLcjfoPBJu4kuGYDH5/
 GR5ojqoOiZojXNZxwcAEI3J531h1TuVECyrulabYb15xWRhrSXhIDZJt2V/dkwIHHYwUHbqMArg
 jLX8CACPg4dhR4yLI8a2lVzPN9qRRggC1hRqH0W7+b72zbISOsbRkC0zSX1qoL47TqWSQlIKZx8
 7OgThPeIyg96zoj17N1iAESzRBAbR0Xpx5aqBcc5hRrfpMMYeBdoSaebsi5pWTEXp8/3uVikKr3
 bLJ5QOblyrGfQQrVrVz9o3x7noaVCQqMUKL64=
X-Received: by 2002:a05:690c:c3c6:b0:8b0:9e7c:7b11 with SMTP id
 00721157ae682-8b1c68a8d2amr14998497b3.32.1793284265969; Thu, 29 Oct 2026
 07:31:05 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019-upstream-optee_rpmb_b4-v3-0-c97cf24fc56f@oss.qualcomm.com>
 <20261019-upstream-optee_rpmb_b4-v3-2-c97cf24fc56f@oss.qualcomm.com>
 <CAC_iWjL5V9q=4aJF-T_FXjTTevy6ix2L-PEfE8UcP8riR-duAQ@mail.gmail.com>
 <CAPzfCAZzkoY5=1BQ6Shn1EDSF-zscT4jeNwT+v7spyD8X5PT4w@mail.gmail.com>
In-Reply-To: <CAPzfCAZzkoY5=1BQ6Shn1EDSF-zscT4jeNwT+v7spyD8X5PT4w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 29 Oct 2026 16:30:29 +0200
X-Gm-Features: AclHuK9up6vEVyCHF_LAe-JKLuzwqWx_fBPuEMaRD2VTuGfRueekwAR6U9uLzNI
Message-ID: <CAC_iWjJ-gfCye1_q7wXgTjxBjCZWRqrxw8XDo1z00_kHkw1RHA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] optee: do not announce RPMB from within a
 supplicant RPC
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 at 16:07, Igor Opaniuk
<igor.opaniuk@oss.qualcomm.com> wrote:
>
> Hi Ilias,
>
> On Thu, Oct 29, 2026 at 2:36=E2=80=AFPM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Igor,
> >
> > On Mon, 19 Oct 2026 at 15:10, Igor Opaniuk
> > <igor.opaniuk@oss.qualcomm.com> wrote:
> >
> > [...]
> >
> > >
> > > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> > > ---
> > >  drivers/tee/optee/core.c          |  7 +++++++
> > >  drivers/tee/optee/optee_private.h |  2 ++
> > >  drivers/tee/optee/rpmb.c          | 11 +++++++++++
> > >  3 files changed, 20 insertions(+)
> > >
> > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > index a47c76811cd..f7670096b61 100644
> > > --- a/drivers/tee/optee/core.c
> > > +++ b/drivers/tee/optee/core.c
> > > @@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *param=
s, uint num_params,
> > >  static void handle_rpc(struct udevice *dev, struct rpc_param *param,
> > >                        void *page_list)
> > >  {
> > > +       struct optee_private *priv =3D dev_get_priv(dev);
> > >         struct tee_shm *shm;
> > >
> > >         switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> > > @@ -450,7 +451,13 @@ static void handle_rpc(struct udevice *dev, stru=
ct rpc_param *param,
> > >                 break;
> > >         case OPTEE_SMC_RPC_FUNC_CMD:
> > >                 shm =3D reg_pair_to_ptr(param->a1, param->a2);
> > > +               /*
> > > +                * Tracked here rather than in optee_suppl_cmd(), whi=
ch the
> > > +                * sandbox TEE driver shares with its own private dat=
a.
> > > +                */
> > > +               priv->in_supplicant++;
> > >                 optee_suppl_cmd(dev, shm, page_list);
> > > +               priv->in_supplicant--;
> > >                 break;
> > >         default:
> > >                 break;
> > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/op=
tee_private.h
> > > index daff3e04493..92e3b3bea10 100644
> > > --- a/drivers/tee/optee/optee_private.h
> > > +++ b/drivers/tee/optee/optee_private.h
> > > @@ -42,6 +42,8 @@ struct optee_private {
> > >         struct mmc *rpmb_mmc;
> > >         int rpmb_dev_id;
> > >         int rpmb_original_part;
> > > +       /* Non-zero while a supplicant RPC from OP-TEE is being servi=
ced */
> > > +       int in_supplicant;
> > >  };
> >
> > I am not sure what was fixed since the last version.
> The changelog is in the cover letter [1]. For this patch, v3 moves the
> counter back into handle_rpc(), where v1 had it. v2 had moved it into
> optee_suppl_cmd(), but the sandbox TEE driver calls that with its own
> private data, so v2 wrote into sandbox_tee_state (the issue you've report=
ed)
>
> [1] https://lore.kernel.org/r/20261019-upstream-optee_rpmb_b4-v3-0-c97cf2=
4fc56f@oss.qualcomm.com
>
> > This is only defined on private data  for !sandbox right?
> > Then it's used unconditionally in handle_rpc(). Won't that break builds=
?

My bad on the previous message, I meant UFS not sandbox*

With this config
CONFIG_ARM=3Dy
CONFIG_KVM_VIRT_INS=3Dy
CONFIG_ARCH_QEMU=3Dy
CONFIG_SYS_MALLOC_LEN=3D0x1000000
CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x40200000
CONFIG_ENV_SIZE=3D0x40000
CONFIG_ENV_SECT_SIZE=3D0x40000
CONFIG_OF_LIBFDT_OVERLAY=3Dy
CONFIG_SYS_LOAD_ADDR=3D0x40200000
CONFIG_DEBUG_UART_BASE=3D0x9000000
CONFIG_DEBUG_UART_CLOCK=3D0
CONFIG_ARMV8_CRYPTO=3Dy
CONFIG_ENV_ADDR=3D0x4000000
CONFIG_PCI=3Dy
CONFIG_DEBUG_UART=3Dy
CONFIG_RELOC_ADDR_TOP=3Dy
CONFIG_EFI_HTTP_BOOT=3Dy
CONFIG_FIT=3Dy
CONFIG_FIT_SIGNATURE=3Dy
CONFIG_FIT_VERBOSE=3Dy
CONFIG_FIT_BEST_MATCH=3Dy
CONFIG_BOOTSTD_FULL=3Dy
CONFIG_LEGACY_IMAGE_FORMAT=3Dy
CONFIG_USE_PREBOOT=3Dy
# CONFIG_DISPLAY_CPUINFO is not set
# CONFIG_DISPLAY_BOARDINFO is not set
# CONFIG_BOARD_INIT is not set
CONFIG_PCI_INIT_R=3Dy
CONFIG_BLOBLIST=3Dy
CONFIG_CMD_SMBIOS=3Dy
CONFIG_CMD_BOOTZ=3Dy
CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
CONFIG_CMD_NVEDIT_EFI=3Dy
CONFIG_CMD_DFU=3Dy
CONFIG_CMD_MTD=3Dy
CONFIG_CMD_PCI=3Dy
CONFIG_CMD_UFS=3Dy
CONFIG_CMD_NFS=3Dy
CONFIG_CMD_SNTP=3Dy
CONFIG_CMD_TFTPSRV=3Dy
CONFIG_WGET_HTTPS=3Dy
CONFIG_WGET_CACERT=3Dy
CONFIG_CMD_EFIDEBUG=3Dy
CONFIG_CMD_TPM=3Dy
CONFIG_CMD_MTDPARTS=3Dy
CONFIG_CMD_SPAWN=3Dy
CONFIG_ENV_IS_IN_FLASH=3Dy
CONFIG_NET_LWIP=3Dy
CONFIG_NET_9P=3Dy
CONFIG_AHCI=3Dy
CONFIG_SCSI_AHCI=3Dy
CONFIG_AHCI_PCI=3Dy
CONFIG_DFU_MTD=3Dy
CONFIG_DFU_RAM=3Dy
# CONFIG_MMC is not set
CONFIG_MTD=3Dy
CONFIG_DM_MTD=3Dy
CONFIG_MTD_NOR_FLASH=3Dy
CONFIG_FLASH_SHOW_PROGRESS=3D0
CONFIG_CFI_FLASH=3Dy
CONFIG_CFI_FLASH_USE_WEAK_ACCESSORS=3Dy
CONFIG_SYS_FLASH_USE_BUFFER_WRITE=3Dy
CONFIG_FLASH_CFI_MTD=3Dy
CONFIG_SYS_FLASH_CFI=3Dy
CONFIG_SYS_MAX_FLASH_SECT=3D256
CONFIG_SYS_MAX_FLASH_BANKS=3D2
CONFIG_SYS_MAX_FLASH_BANKS_DETECT=3Dy
CONFIG_E1000=3Dy
CONFIG_NVME_PCI=3Dy
CONFIG_PCIE_ECAM_GENERIC=3Dy
CONFIG_SCSI=3Dy
CONFIG_DEBUG_UART_PL011=3Dy
CONFIG_DEBUG_UART_SHIFT=3D2
CONFIG_SYSINFO=3Dy
CONFIG_SYSINFO_SMBIOS=3Dy
CONFIG_SYSRESET=3Dy
CONFIG_SYSRESET_CMD_POWEROFF=3Dy
CONFIG_SYSRESET_PSCI=3Dy
CONFIG_TEE=3Dy
CONFIG_OPTEE=3Dy
CONFIG_TPM2_MMIO=3Dy
CONFIG_USB_EHCI_HCD=3Dy
CONFIG_USB_EHCI_PCI=3Dy
CONFIG_UFS=3Dy
CONFIG_UFS_CADENCE=3Dy
CONFIG_UFS_PCI=3Dy
CONFIG_UFS_RENESAS=3Dy
CONFIG_UFS_RENESAS_GEN5=3Dy
CONFIG_UFS_TI_J721E=3Dy
CONFIG_SUPPORT_UFS_RPMB=3Dy
CONFIG_VIRTIO_9P=3Dy
CONFIG_FS_9P=3Dy
CONFIG_MBEDTLS_LIB=3Dy
CONFIG_TPM=3Dy
CONFIG_TPM_PCR_ALLOCATE=3Dy
CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=3Dy
CONFIG_UTHREAD=3Dy
CONFIG_UNIT_TEST=3Dy

I am getting

drivers/tee/optee/core.c: In function =E2=80=98handle_rpc=E2=80=99:
drivers/tee/optee/core.c:458:21: error: =E2=80=98struct optee_private=E2=80=
=99 has no
member named =E2=80=98in_supplicant=E2=80=99
  458 |                 priv->in_supplicant++;
      |                     ^~
drivers/tee/optee/core.c:460:21: error: =E2=80=98struct optee_private=E2=80=
=99 has no
member named =E2=80=98in_supplicant=E2=80=99
  460 |                 priv->in_supplicant--;
      |                     ^~
  CC      lib/efi_selftest/efi_selftest_miniapp_exit.o

Cheers
/Ilias
>
> The field is not conditional, struct optee_private always has it.
> handle_rpc() is in core.c, which is only built with CONFIG_OPTEE, and
> the sandbox TEE driver never calls it. The only other user is
> optee_rpmb_available(), and it skips every TEE device that is not bound
> to the "optee" driver before calling dev_get_priv(). So nothing reads
> the field from a sandbox device.
>
> Btw, the series builds with -Werror for sandbox_defconfig, for sandbox wi=
th
> CONFIG_SUPPORT_EMMC_RPMB=3Dy (so rpmb.c is built next to the sandbox TEE
> driver) and for qemu_arm64 with OPTEE and SUPPORT_EMMC_RPMB.
>
> >
> > >
> > >  struct optee_msg_arg;
> > > diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> > > index d4abc48f764..a40573c9281 100644
> > > --- a/drivers/tee/optee/rpmb.c
> > > +++ b/drivers/tee/optee/rpmb.c
> > > @@ -210,6 +210,7 @@ void optee_suppl_rpmb_release(struct udevice *dev=
)
> > >
> > >  void optee_rpmb_available(void)
> > >  {
> > > +       struct optee_private *priv;
> > >         struct udevice *dev;
> > >         struct uclass *uc;
> > >         u32 tee_sess;
> > > @@ -219,6 +220,16 @@ void optee_rpmb_available(void)
> > >                     !device_active(dev))
> > >                         continue;
> > >
> > > +               /*
> > > +                * mmc_init() may run from the RPMB supplicant itself=
, while
> > > +                * OP-TEE is blocked in that RPC and holds its RPMB l=
ock. A
> > > +                * nested call would then deadlock, and OP-TEE is abo=
ut to use
> > > +                * the device anyway.
> > > +                */
> > > +               priv =3D dev_get_priv(dev);
> > > +               if (priv->in_supplicant)
> > > +                       continue;
> > > +
> > >                 if (optee_open_enum_session(dev, &tee_sess) !=3D 0)
> > >                         continue;
> > >
> > >
> > > --
> > > 2.53.0
> > >

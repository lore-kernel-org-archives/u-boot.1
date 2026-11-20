Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BCE606A326
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 00:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iP9IoWpj;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cl6zoTHk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1067560E22;
	Fri, 20 Nov 2026 00:53:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ycYn8bpQ-5J0; Fri, 20 Nov 2026 00:52:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3BD3F60E02
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795135979;
	b=QqSTKlMnHJkV+UdChC+UCMmX+TdFs5//NdzrQ1hLhUDktya+Rw0BTsfCT/fZ0aOw8cCr
	 +7oZVOe1N+1J/y0zFt/+OkQqsioyiCdjXtNvFxKEFNqrDXOKtg59mE6OzPkfg3exLPJI2
	 g0F12dqj2fp6m7eTz7lDWrTAv/fluqlOKhuAMMdV5N2lnOv2KlSLHr7Iej3Qzpn6/4r4b
	 KXJQaj0S+bC7jdjUFIKahO14bKg4dre9wTm5Ox1bOGdInblos/C5P15t7USADxHJA6ByN
	 7jBHrXzgDORT29RpZFYPKWyEatpyE8RLXTcxLC2KycVi3mdl24OYUXmTYOJyXsVh2fA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795135979;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+PUJsk03VhlYFW182ednDQQ+01XaC0WbL3v2TE1E23o=;
	b=Or1SsV6GC86EsqydleauMhLPY9VTw8hOk25OGBDsEiDDrSe2f709/JsZsyXKcgyhNZ3T
	 aRZuPgfMssqQyEWhXlrz5Q6gLa8Zntcf/iOZsx0rrv6TauZoSgTnsCBXfd+Pccz3W56b+
	 jOmzH8aGFKLGkjfbakOpOR37LJW5P+9npGXO+XzRtdsOJ4Md9dbhMWVMpqpgY2H0+DS2v
	 6oKMLbeWcUmskETr3wo8mKWFLCs4nM0xS/MYjjutICk02AhOwuJ+BmhRMam2zdOv7dXdG
	 MD1+gbjtSd/ecfUjnL5uDkRJEx8rbSBwZBhlcwRU3VIMQIiOzcMScUNUJrLYLsTgKSw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795135979;
	bh=+PUJsk03VhlYFW182ednDQQ+01XaC0WbL3v2TE1E23o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iP9IoWpjsqHLmEQIHou2OKs2PMq1nhkuRa2ciYSaR+e1Yjel6M8V7TLajq+mkI59m
	 86+q1m7F6V6xC00th2QEHIORlVIuKHmsrFaucscTdF2mXLm9eF1ubNILNhIBI1a8iI
	 AbB+nF4itAUftl9qaOnihR3PYvwbzF44N7QYeJmV8GO416QKOz6YXVQd1NjlXXavca
	 2APKb3Wv7OKXLhqcOGCaI4Nw0I03JuQD0HucYB1vJzaJD3ZQnINpwevyAmOE/DtTFC
	 WhBFfPl6GWtknA//eKTC3dvq2rzwtR0QSoIMjZTxGqn5/qseAQYQhxHSGmM9jH2cEi
	 C46f4q64wj0Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BD3F60E02;
	Fri, 20 Nov 2026 00:52:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A5240169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96C49815D1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:52:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gCCmYWIUcovC for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 00:52:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ACE84815CC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Cl6zoTHk
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ACE84815CC
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:52:56 +0000 (UTC)
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-675617e81f9so515529d50.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795135975; x=1795740775;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+PUJsk03VhlYFW182ednDQQ+01XaC0WbL3v2TE1E23o=;
 b=Cl6zoTHk5od+C6UsiMVvGk95KkG2R1WLieiH6vI23HuiiWpW92qDNj43dcp19GPPPs
 xuRkKeYBjxaMmPrjf6jnUOyFwoQW6r/n2/cyq8TQrPiednA4pfINnWQ6kLD3Agx2FSP/
 TuKbH8jrwa11Mw8daNALQi5rIgt7zPyTNRDBIZkvgscQOs3zvetyXPHBpJzDMLV3aO2D
 1DtH0NEjt1VVK6h1ey2mpBsDRyQiZT1Q+Ej8wecagAujIO0biL28Ky21dBOM45oYYH6q
 FKWe9rtVDfeqIzCmS+pGBgr3kDtaOhlio8SiFRR6Kbrzka2/SCb9X5WBDLBjQPMBaRLZ
 9pMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795135975; x=1795740775;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+PUJsk03VhlYFW182ednDQQ+01XaC0WbL3v2TE1E23o=;
 b=2WucoNATgujTeTQOvxmJKFmS+D2vrhe3AtXxQ4QFPGg8WxEcb141gNx4HdBq3msmdr
 ya5QycYbC+K4rIR1NZp6a+7eW+D2lDpjXUmiQ1uz7SQ9xu1kJa5QqSQO8ZOnMvZu07SE
 CnQr3mAUytFYITKFfvN5mHneg6qw3OQxFllby1gkTGNXeL0MzCAia5ER5FG88AB6Fou0
 yCQMgToFo9vx9nfaaNHcBSabeGMeSE0qesCLenJdQ3VkTiZLqt5nSoAdlPd7bKLUyn9Y
 tqba7+INxu9hy+6hiqYBMz37rOG8HjPylMTzEJd1Q5aIGq8zFovexIydbyoncF3HTT/T
 3Dfg==
X-Forwarded-Encrypted: i=1;
 AL+hErEBVCh+ES6efvTFix61/drMduYsn6qHM7qNn7RDrYkYA7pPGNAl/f9D9gDjgSJzmaDcBpLFbEQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/eMsUbpjrZN2kBkYSKsR9wxnF5YYYNk7QRFu43ltbcXwEybWgE
 VeOEo7bIISKluh0izZCfStFCY5yfYl9HmkyEX1cnzok0d7nqOFqGm4KEf/n2QVsCTxKpLR1M5xN
 JIm0GjvQEUea+PYxYygqe3n9owQvGhxk=
X-Gm-Gg: AZFdTZfCl2SEpjXAjo+VunnPmkwuwuoKooXorAJm/4iHw/NGqZykhux+/n7rF0ePjk9
 OEZehY/yWcjMmn0JJAfOtOc+wf5b7HK5rPetn73T4oHaST9Y2ZsSejww3/VN8whMJajIc3teXeC
 EIh7THkvBCe9MjWMq1q/X9nVuWnMNg+9Xp584s0Lt7yTuj63LUYgWV/TEN943zpyDXkj5qou3Ho
 hO7qqpWMotqYsepOk6fDNC5d5SuQwMc0JVozln52kasZL1tiXW6DalmSa6Kky5vPXKhpt9SXMyJ
 kgSozsdfJw7ihGWm53GlwO8Uq3TZ4rNfgsScqauT43M2BkEOpeBaQyhCykWhnGe8iT3c5dsYokw
 GPG4mM8HalUT1nEdnV2wQL4pqiTdffukf3pvL4u+PYWcIsX5aDD7MYKV9sXbrfCIilEh8lHmZbr
 Yn+xeZYCYULM/pk/xhMA==
X-Received: by 2002:a05:690e:138f:b0:67b:f465:bbe6 with SMTP id
 956f58d0204a3-67df43cb8e3mr605279d50.35.1795135974976; Thu, 19 Nov 2026
 16:52:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net>
 <20261113-nvme-fixes-v1-3-a181c72f40e7@flipper.net>
In-Reply-To: <20261113-nvme-fixes-v1-3-a181c72f40e7@flipper.net>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 20 Nov 2026 08:52:43 +0800
X-Gm-Features: AclHuK9IV-6Su79o9Fxut_GdoWlp5525g5ZS3gse6d0Mgl38356Bf2y19ZUp9Vg
Message-ID: <CAEUhbmWGwG1y6rXVopFGLmioyRyxW6_u0nWjphaKiy5G=BwjEA@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvme: Drop late completions of commands that timed out
To: Alexey Charkov <alchark@flipper.net>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org,
 Zhikang Zhang <zhikang.zhang@nxp.com>, Wenbin Song <wenbin.song@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Prashant Kamble <prashant.kamble223@gmail.com>, 
 Torsten Duwe <duwe@suse.de>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 8:00=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
>
> When a command times out, nvme_submit_sync_cmd() returns without
> consuming its completion queue entry, so the entry posted when the
> command does finish is taken as the completion of the next command.
> That command then returns before its own data has arrived, and every
> later one stays a completion behind for as long as the queue lives.
>
> On a Rock 5B whose disk is slow to serve its first read, this turns a
> failed GPT probe of LBA 0 into a successful DOS probe, which consumes
> the late completion of the GPT read and leaves the disk recorded as
> having a single whole-disk partition of type 0xee.
>
> Check the command ID of each completion, and consume the entries of
> other commands instead of returning them, so a timed-out command no
> longer desynchronises the queue.
>
> Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  drivers/nvme/nvme.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index a7950227abb8..37f5a3ce4b10 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -209,8 +209,22 @@ static int nvme_submit_sync_cmd(struct nvme_queue *n=
vmeq,
>
>         for (;;) {
>                 status =3D nvme_read_completion_status(nvmeq, nvmeq->cq_h=
ead);
> -               if ((status & 0x01) =3D=3D nvmeq->cq_phase)
> -                       break;
> +               if ((status & 0x01) =3D=3D nvmeq->cq_phase) {
> +                       u16 cid =3D readw(&nvmeq->cqes[nvmeq->cq_head].co=
mmand_id);

I think this should be using le16_to_cpu()

> +
> +                       if (cid =3D=3D le16_to_cpu(cmd->common.command_id=
))

Just cid =3D=3D cmd->common.command_id, because cmd->common.command_id is
already host endian by nvme_get_cmd_id()

> +                               break;
> +
> +                       /*
> +                        * A command which timed out earlier has complete=
d
> +                        * after all. Consume its entry, so that it is no=
t
> +                        * taken for the completion of this command.
> +                        */
> +                       pr_warn("nvme: dropping late completion of cmd %#=
x\n",
> +                               cid);
> +                       nvme_consume_cqe(nvmeq);
> +                       continue;
> +               }
>                 if (timeout_us > 0 && (timer_get_us() - start_time)
>                     >=3D timeout_us) {
>                         pr_warn("nvme: cmd %#x timed out\n", cmd->common.=
command_id);
>
> --

Regards,
Bin

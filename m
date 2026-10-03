Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619BECA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25688412CE;
	Sat,  3 Oct 2026 13:01:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YtcoDABokQZe; Sat,  3 Oct 2026 13:01:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6592141324
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032495;
	b=W2a9SHhRehTiIOhzpQM1JOv6glC7o2c2AI3dgsNzJSDXh+DYv6czhAzZmsTe8aPyU8au
	 Gj2EmOENbRma/g0j/cD2VCF77FUvjIryRZ1FjWDrVwWHONIAPZg2r8kd5ghhbHzHDQUlc
	 3xt7d/6wLeogf/La2PTikxYQSeZEM+XPT8YwGHzGcnqYYNE79wrDNwskZ2InlnVsIsiuU
	 k3b9bHI9R2wW4g0G9d5H1DqSfjCAQ9fbGj7Hftx9iwYdPb9DNq0UYwyvTFoZ4QjvC/GMN
	 b10AuRV8T5gkNKMDH1X+Fi1d79dD+l7COQXHNa3UH09/XUzeBqIMoojdtZ/L5pU0Ihg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791032495;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4zxrj2WrNWkKN5BJp4LkRg3gd12+kHzIvcrxH26o/to=;
	b=fMRa3WIEXiJlRlsvg6zbR6BEE+agFHqmCD0jYROwvRxNuBHUHlPOdK4gZXjZAGLrfOz1
	 pWSi/fj0YwPR6/yztV3gLF/KolxwYvC862sMoynz/UQGUpytYI22Vs16qVt1yHHiGCf4u
	 gwGPcAyqERQbrIwhDQHlsXNN86JJE5B9bgWYDa1Bji/pjsUzdrl2VBwCEJlMeKkNDmNUp
	 PnYcSIi56/j4xxA5nl88qkKAyG46/WG1LrWHE2m5ECplsNQL2nC1Kj5HfhnO7PtW8b0Op
	 /yOgRsNcjC0vEiAPzuxMmDgO5sRjTvryOM6iP4GPdeKwCYimnUw26gb9ZARBD2gtWcA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791032495;
	bh=4zxrj2WrNWkKN5BJp4LkRg3gd12+kHzIvcrxH26o/to=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L/gEatvUHiJZq26trcCx4wGOiJkmQmcLLF28hwdaGmv3/6KBHyK/UuWGEvGb25xky
	 LmLd0NFaQNamcz3fXuwzaTWR6zkbTjss60Z+4Gdn0tYTTliBYMIPNg7tQN/VoKKxpV
	 O60jWIN5gMrN7uCeLM7wJw7mPaeuTedAzu52w/mg5gltMug9TiauFy5NTUzUl9Zi42
	 U6eeoY8MZjK/CHarYBbSAb5n2AmYkjceTxXYihum2kn3jtc5OGAtHflAuTdth/ymWT
	 g1g82yfzETsGvpeB1zWaVFpjnfABEQD/Oq4GP1xxnwnkQx6gOtFxJ1YOQGVjXkgZOV
	 tZB8Rp4TDV1Hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6592141324;
	Sat,  3 Oct 2026 13:01:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BCB11A6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71ECE40064
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:01:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QNK6KzWtUWnc for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:01:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7771A40024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032492;
 b=fjB7C0l95DExHymxZ/F1heUVpzrrYjN5PyJgt0JyWZp+kb1ivkvL3bpIr8PAYBcE86s/
 4oVVQXJqM49VLsh6Cg9mT7VCDBKwPlZqN3Pp97XFJYxgaa1ZtX3beOjV66rFq/IQF9CsV
 9rgZ0vJNpzcdwJA1vHLGepegJfdyx1zonbfQA9mAx/r7MWsiNfDjypnBuZkm+9D1ntBTj
 VpxviepRzu/TvGOw3fJZnGycrdxZ4b8cVGij7IgGwojOiTuOtQ7yvEDB08ZMkWPnR6d7g
 Zvc/qHR/RXTZtznmw6NXoOLoHlVXtIKuO9YVRo5HiVM34soooDp//82M58ThoGbgY6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791032492;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=4zxrj2WrNWkKN5BJp4LkRg3gd12+kHzIvcrxH26o/to=;
 b=JmLHwAE7U5hoVJOZeA6e8VDaBn7zG3YY3VdyrGDZHEOq3obcoRG6yB69tj7qdCobc4cB
 I7s2ZLB6ItuH/NfU1szKRWgvM/vSMashfHI28NbG/9V56Pq00aPXKJ4GXJmuQVjtqei+r
 HEFcXiLjFaLSy/HMCABSngtKRGfgT2r3MXwUXbIfmGDLDBOE6B3XsfZ7rksrG6CC6kUpm
 56E8VE+vtoRK8OGAr5Xoa0jimk7eyuztb8jOQveE7BU+MaYAiW0wLVL3j0/m4ACZsNp6w
 BjBUBRUjErAYn/LroSQLW0orSwm9Yybs44z6fJQHMrciyeLMfdpY5e9eIe9U23A3tuw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fTO49FTh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fTO49FTh
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7771A40024
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:01:32 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a996c8adf3so532013a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791032490; cv=none;
 d=google.com; s=arc-20260327;
 b=dbvvXkY4Hgj0NihZY1tQG+Jh0X0mPPwOhk27kJYeXAVN3rtvp0Caet4khfjUW8//o+
 P6yo0Yh7PZtGL9iFCu1NeLOS2Hj67oPbVL0sQnpMfihvIIDyfkYE+ai8SmFYSPlCXqII
 mLOPoz6l1YlG4dDAY6044486v1G295HaqLs1VTYu96w+6ixleb0tAkebnxQ1eXOB/1Nz
 aA4WFAU1cz7aPP7We5Hj9oiG55PkXOMMppJtvxNfQPlcM6DgVI2KxRBEu82UXnp+qFzn
 rMPTtOZUIxp3IaFOVghepjabg/8mjpRbswBNAlRuc7uvMXJE0F1OtOA519tCyIIDXaJ/
 Ra5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4zxrj2WrNWkKN5BJp4LkRg3gd12+kHzIvcrxH26o/to=;
 fh=BEoPNN0ojtgxNz8fjZSoyMObtb+XDDU+qZjnWDTAHBk=;
 b=r/29aC9G8XVwA4Dytezk5+Wu8sQN0v0mgcOLoHBZGyLjzlJ0w6S0Gw++p6/MAek8A/
 0QFtGGIxbdVXnMCfMBHgOw5kAxqGn2ATSQsXSvLbq2viNEF3tLU3Qa3mxgvDh7kW5z3Q
 2tHD3ZqXj6VV+OzZpctJ6XjLSlSH/X5QrYgX5McGcYillRV01sjJH8LMDaWlVia8pSC8
 47lazMl7vNGv0jVK4dI/McvvSlgFX6uaqFe6cVO/3Yqo5C8husS7AoqcCFu2G1CNsLoX
 BC1bRZPjOZ9teIOzvv8Dm02ZZunU5ZRF8nHdVTRVhOvS/16/UQCsvfXzy9Fttc50dfx5
 7Xpg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791032490; x=1791637290;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4zxrj2WrNWkKN5BJp4LkRg3gd12+kHzIvcrxH26o/to=;
 b=fTO49FThFBEw/UfGkYek9eoMFshrB0AHGSsCEB2oIbij82PfpzGUfJ5Lxwbb9/666p
 s43ocbyCDD/DJYH655NJBC74GaD+dmcqpptMcfYK8KqJCxFJ31WuXH87np8q8nWC1fUr
 6sZU5ANBt0CLJg3jq+F6DESIiv0CahQy+MFNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791032490; x=1791637290;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4zxrj2WrNWkKN5BJp4LkRg3gd12+kHzIvcrxH26o/to=;
 b=vz6JY5neLXOTGdxESFGzP6mHLQXIpbyzYnF82gv9W3lUfPAEnIvCBrOF7Jj3Ig+6jm
 9oWiKciIdmm3rTjeAJg2xbo2v3qGGIhkFx2kv/HtwPY5PBCCSt4brMJPAbxQJIuCPs0Q
 HHXjQvSIP8azu4H9IxCt3qoYsjXgwpQRtDZIupfIwjk9vZ9MZbJdZ7Q8nR8wwdUigZ/W
 4Am8YXkLgRpqYCK1jEVms+Ms1M4STpS8aB79GOpVeqE7amo5u+kekjbN2BQim0pepn4l
 +aBlyfb2G3Yml6R1gtD6Z6hia6oxKK//MwtQfNjLHdU1t4sqe7rrSyXazkFpOPpq3sI6
 Y84w==
X-Gm-Message-State: AFq9FYKPTyTvX+MOYspZ8bMV62mVPDmpaN5KhNwUd6mhIA+4kCbH4gTZ
 9KsgeoBbfBNlEplWPiBg208zmJw5dH+vK5TSyYus03nDlz+zQ38tXMTbJGplHB6vusiJVDiqrss
 +Tl5KxgZxUy1JbeHHH349oT0nmj8XKqsXfk5Pco+v
X-Gm-Gg: AYBFou25j1WvkIb0eFaYT5RgvuguHcnUVrLwjw3lB+Xu76vQrzd4Fv6BGv0Ufds9EoF
 BX0DVG0EEMxIKQrsjfk8aSW4Jo7ypxa4jbouej7AnstgyjWIHStKD1p5djqth15pxO1vrT48h5s
 Rf7f9HFTNYSEgWszW+WG/fvK8pXJ79nmdmOR2GOjR5R+gbANijqUTKtGlsIzK5ComoD3rxrEa0b
 PtjAT21kh8igKaEMGhr7c0gNqQF6xqoK3DFqYvy5TI//g1jsiv09vXf1wls3VwW02rDaaeT1XkZ
 KUTus7OtLNyaiE14dn/LjHYHEWb9VwipI+palBjvpjhXFUoulx0TZsdZ
X-Received: by 2002:a05:6402:3228:b0:6aa:f1d2:ddb8 with SMTP id
 4fb4d7f45d1cf-6af9e31bcdfmr4357014a12.23.1791032489881; Sat, 03 Oct 2026
 06:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
 <20260918-ufs-spl-boot-wlu-v2-1-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-1-8a63e372bb6e@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:00:30 +0100
X-Gm-Features: AclHuK9E0ts-pHoyhIaLzkbSC1qMXBLIees9RW7bLGmksDOmtdmcYfEgM785Xsw
Message-ID: <CAFLszTjAyHTKvm0anAYD6kmUjAxWM8OCTfRJ-Ump70Nd0h3==Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] ufs: hand sense data to the SCSI layer
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>, 
 Denis Mukhin <dmukhin@ford.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Alexey,

On 2026-09-18T06:35:41, Alexey Charkov <alchark@flipper.net> wrote:
> ufs: hand sense data to the SCSI layer
>
> A logical unit exposes a CHECK CONDITION through its sense data, and
> without it a caller cannot tell a transient condition from a permanent
> one. struct scsi_cmd has carried a sense buffer all along that no driver
> ever filled, so fill it, and clear the length in scsi_exec() so that one
> command cannot be read as another's sense.

Not quite. common/usb_storage.c fills sense_buf from its REQUEST
SENSE, although it never sets sensedatalen and does not go through
scsi_exec(). Please can you reword this, e.g. to say that no driver in
the SCSI uclass fills it?

The patch also starts setting pccb->status, which is not mentioned here.

>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> drivers/scsi/scsi-uclass.c |  3 +++
>  drivers/ufs/ufs-uclass.c   | 23 ++++++++++++++++++++++-
>  2 files changed, 25 insertions(+), 1 deletion(-)

> diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
> @@ -22,6 +22,9 @@ int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
> +     /* Whatever a previous command left behind is not this command's sense */
> +     pccb->sensedatalen = 0;
> +

This changes the uclass for every SCSI driver, under a 'ufs:' subject.
I suspect it would be better as its own 'scsi:' patch, ahead of this
one. What do you think?

> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> @@ -1683,8 +1701,11 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
> -                     if (scsi_status)
> +                     if (scsi_status) {
> +                             ufshcd_copy_sense_data(hba, pccb);
> +                             pccb->status = scsi_status;
>                               return -EINVAL;

The status is only written on failure and scsi.c uses a single static
tempccb for everything, so a later command that succeeds still shows
the old status. That is the same problem you are solving for
sensedatalen, so please can you clear the status in scsi_exec() as
well, or set it unconditionally here?

Also, as far as I can see nothing in the series reads pccb->status,
since scsi_unit_attention() in the next patch only looks at the sense
data. Either check for CHECK CONDITION there before trusting the sense
buffer, or drop this line.

Regards,
Simon

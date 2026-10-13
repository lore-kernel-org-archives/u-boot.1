Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4594CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 03:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 811A2405CC;
	Tue, 13 Oct 2026 03:31:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZSMjGa1mq8kp; Tue, 13 Oct 2026 03:31:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9347B405A4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862283;
	b=ROEFYm7vjz/PrazGZXdPJdY35dzjKhVKqatyNLAmrttDeUxDQpILNkfP4IXzrast1kBr
	 RtabURY6BLViqRHUxqw3PY0YUit0NjBnQ7NJjxBv0JIwAxvLU6A00b/JxxjvjS51jbum5
	 XdksMQ5HmSthGL32hz1E5wCxL56BBiTZD/SSCJTEZDiQqAam4RrY2L0D0xrNKl9AdPxOz
	 2f4CdEc9OnR43JA6Y77DHPl6Mpxu8q+VDgGQdsgd2iGWo94FkPTSuXWNrBxEdIcuzqzp3
	 bI1QtYN5Bmi1bbhDU4TqpBiub7StRUJLQdtYk2wIkg5eRuTzyx+fdYXsUvshGmwnbpg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791862283;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vcbZqrGBsK7o8arezNi7wMlzSqOMC0gjg9LpaUiRj/I=;
	b=ImB9AtJIgwRcH+IdsPID6IMoYjVRHd3fDMZknQNVijM20b3Iav463n5XNMQtakFWgVBK
	 hGxUQkvz4yyhyM68oj6N6xVsEq+XCV5CH+ZBqDJsHXdR9Cz7cp1S0uYSZSmVdVJU3riFt
	 5NJPJ1jybIVTo10hx+oBwP72Pbm4EXx5gvoVFk+yvMRGhgtSTu7dvgpHy6M9WercD0y37
	 A2Lg9EKhRdatpv+4l0Gnjfj3mukPjM2FU3bEQjkSNYi2o5DJXH9qq8jUaZaulXXJYJ2Sl
	 dcL06c9smiuIIZau4+wob9A8MDsD0GFf2IIoQCfpW19EJvMZWPelFK+fWs+W/05BC4w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791862283;
	bh=vcbZqrGBsK7o8arezNi7wMlzSqOMC0gjg9LpaUiRj/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DdkAqCEVA2jP5KpQSnaq111tqnUv9FRoH/SnaTqjLEQTP0c3ZxtcBgyfFAteTWKGb
	 gMYd458Xfrh5IyoiesAn9VB3i7puQGpCSxvwwgzt0UHzpYhaRY6zuf2cwZTQY7RQsF
	 W8T4nEQFiYsMzMLYdOPOXouk8tuKGMnk9fND42mDohTXvGfC9WG3IYMQhnHfkzkUEF
	 TIdPNHGHSAaqlxSunNGL/38EoN4enZcfBkGHU2LhA68fiZlPdH8q9XkkwgPtfmOFTb
	 3K8h6sKfRc85JpO3U91qODYT2yITucg/mtU13B12bj4BJVUrQg15CQj5HrxIhpDTLZ
	 2yAyZNPZMsweQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9347B405A4;
	Tue, 13 Oct 2026 03:31:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E4FB51E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6B316073B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:31:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VQ27TrfZwR4e for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 03:31:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 30CF6606A7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862281;
 b=gEPvNpbKWtoE1yCbK9G7Un2QSeRIYN5Kza9pj48JXgYNBUYMb0zqv5EALki4RWAUoOwT
 Cv2VEOW2QU/Orm4MqfkS2SOXtwNxaj5zVfl+Nnv4vm+ekfA9MdrZEvnzECfnm7iBcHZcZ
 SnTMUxDeJ8r4hnqy1/Bz8Xx+ohkKgTu2NSycay3NU7KXIf481HsM3rwv9XTtFpImSQn6S
 E/n+XZ98JTMBQ1AqCYI+I4blM7gnFxaiZkJbkn5ZUNJ/RsF0jt7CeWeeaQ4INVtUOEls2
 BbJf3NNsQ2tEpghsrX979w/oKLM7Gv/5RM9uZlELPeg68uMwNz8PxoDFS/+QE+7/K3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791862281;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=vcbZqrGBsK7o8arezNi7wMlzSqOMC0gjg9LpaUiRj/I=;
 b=XAmtLSTcr5+aZwmCQmN6v3IwtUNSl7ukjcMgbsH2sGgYKwJ/u6qm4g53F82i1eAH9fac
 NWr/8rttPVkr9ab4qf74RanQL3jmHzSu1EdHOt6tkyO6d8RTl7pEqxlj0S59vIL3NeiFG
 1pV+70Q/hcQzNGxJafEdzXrtpVA1A6br/rHSfQ7jrjuaR8NVWJsX+HVUQDjH0BaggXIum
 FknEJq0ohGdXwGGd0HBCL/vYzWpbIwy+j+qjjuWpgeFrTmNcFJvyknTuyOrY51m1wFrkD
 oYa51pUcyfh9LbP/LAy3FLpVHc9wzOMgupH1yXnF015pItURMseguizumOJj4O5yhSA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ED9Fv9Co; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1034"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ED9Fv9Co
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30CF6606A7
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:31:20 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3a4b3ac8fb7so1005511a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862280; cv=none;
 d=google.com; s=arc-20260327;
 b=fyr6GTOVwOb9YFNuEVNXsn2A+jyck1jw+fsFtx0sQ/gOjDprh2luCHsBmz42u/nxKh
 unoU56vEpNIqzh3nV8MwrSvWowbEcNrdM9QhoA1S/rqCijFnEYUIgZr0kW6NPDVok6jH
 AFo0qOqE/kjvlaH1FisFecTbiT0JnQC0u+4ISV2jQd8Qzzv+Z1AjaKPO9SmUF2zc7mlU
 Ff6qVE+sw9WtiAD8HSbXwQ2tL+qiDveIbzLMTxzzpX7S3atHrUpt4yoM6axayoCvKRcy
 P8bK+mbX0cwmZ7EQKVskTzJCWZWgA/PAa96lHW09r3QxN6cweplvrnzeLxgHWzLvs0sZ
 FmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vcbZqrGBsK7o8arezNi7wMlzSqOMC0gjg9LpaUiRj/I=;
 fh=s0aO8H2t235zedAC4+qknQB1gFmKrv707ngD0gkIlVY=;
 b=Q/vEcBRE4bms57vY7L2o7KEn0YF5SX5kojYfexuda/GjUaT+RM1hCzg70GOso6zfPV
 LrbuBRluzwOy9CwTSz9BFfklycqeDvq1fPQibq5dXsT8ntpDqgmoIHTo0N6SZuch/+me
 Rd0Qtp1tBB4nnQQyC2KLd5PZ2O2o5ypW5w9f5kLyl531T6qt67h364xwS5RnqJ/DmAFA
 lHYs68mbfrGHMb3HF9sKOqMYXFUNUMrf39+abmmm1a0qItDRY2X8Y2RrgZXSkxcspaVs
 fZxIf9PAy5UUg6KPviXqbwFfc/qrPg+jqTnap8pfjLn2mHAnqTD56lEpRiKRjAbjvuiV
 iPyQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791862280; x=1792467080;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vcbZqrGBsK7o8arezNi7wMlzSqOMC0gjg9LpaUiRj/I=;
 b=ED9Fv9CoTw+KTcMsV6Mkl+hxQttLCbJ1K4nIA4tK974ZJ9mUyozospA2U8rjAWrmDV
 4uKpgPgH7Q+2w/JjHfo3KUu55FTMcO3mZsIaZFbpUx2st4wx/A5DJOf1n8rfNnUZ1LFo
 GsfOikIAXs9B3rJUS5PbVfnKqy6mYghNsv5hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862280; x=1792467080;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vcbZqrGBsK7o8arezNi7wMlzSqOMC0gjg9LpaUiRj/I=;
 b=WzX7KUKOep4AwccSOW95jIPn1e4UNSHR8iwzfNm3YS9eeWBgIIda16g+ox54+Pbfy2
 t5mQRVNb6UomThKYFvYa5LsIeMvVSfAG7h9NONg2aJ0pCMD56QD+5xaxO/Ie4y8/5G79
 Cste+YmyCbUFXqk/Z5xZ6PNZY/jXaTjZuEreWtjoVrzrKsh3/q4bpgJcV48ANb9A1vvv
 OfngH6BuDEiZcrPff/7iqgF5TrJsOy+vjYbCWmrZvalNLm1bmTbZUvaNs9JuJIq2EOTO
 bk2FNK4n9qZE70HaRduKN1fPQi35F/umKqG3nLb4dDVOt2wPqihLB9sy0gQf/iYf35HF
 t7Pw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8N1hJmu6Bk/HS0MvdvJHQwbVpHi/RORbfJLUBq1ArseW27sOhd+HS58X/FoxReuDeHhBlgrY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIvXHoUK6wdzAA8FTc+UgN+SaJW3wzHFSFR7HTqTl3Aq5mqPcFe
 WJB11+1EWfoZIxqZTdqnoUp5FpdhMD2hhuj0cTpUujaJiHnI4cyh4UIF9BhiIrr6WKJXDG40J05
 Cl/5Qu9EuA+g255PqQzcV3jxTiFfOVrPxvmepQu/p4syWkzUwbbPgs/rV
X-Gm-Gg: AYBFou0ublXhU1mt6a6Mai4E//tDcQ5lbTc1xzFjYQhicCGPnDh+US2rIIv9Sgw6kBv
 rw4PdvCALmneU+cQSOe52OApC0PnNWXGhOnAdHH4jTu1lmd5izeXzdpZRhTocbzpGLdmUuVp9vR
 YO6LG2hCopy5KsPgz7KaDDPFCkcYPAYtLP5/ksgv8aTcDhmv4gmMxdlbF6ZY1m7lbTJFvKChP5e
 /CsC3VWPpHT/TuTHGETY4o8FLByoixPbOYye30X99FN45hgZ0h2NszVL2Bjz8VR+sfh8xUIEQEH
 P2dcsz0h+CHNOXhR7ZCMDduSJY/x2gRrVL7X0hEUaJnTCXVPnJY325K4
X-Received: by 2002:a17:90a:e7cb:b0:3aa:ee81:a62d with SMTP id
 98e67ed59e1d1-3ab3a7480f9mr10165350a91.35.1791862280010; Mon, 12 Oct 2026
 20:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
 <20261012140048.214059-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261012140048.214059-6-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 04:31:00 +0100
X-Gm-Features: AclHuK929FrbUR7aOcQqwDw6f1SfnayjkyunAH_oU9aSTpiArx2EkM6gq1U84-k
Message-ID: <CAFLszTirBLO+T=SCyPpuNAV9KmDbwxYd2fois5trtYOERZUBpw@mail.gmail.com>
Subject: Re: [PATCH 5/9] fs: ext4: set inode timestamps on write
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Daniel Munic <v-dmunic@microsoft.com>, 
 Tony Dinh <mibodhi@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>, joaomarcos.costa@bootlin.com, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org, 
 linux-erofs@lists.ozlabs.org
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

Hi Heinrich,

On 2026-10-12T14:00:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> fs: ext4: set inode timestamps on write
>
> Replace the hardcoded zero timestamp in ext4fs_write() with the actual
> current time obtained from the RTC when CONFIG_DM_RTC is enabled.
>
> Per the ext2/3/4 specification (ext2 design document, section 4.2):
>   i_mtime  last data modification time
>   i_ctime  last inode change time (the 'c' stands for 'change', not
>            'create'; this is not a creation timestamp)
>   i_atime  last access time
>
> All three fields are set to the same value since writing data modifies
> both the file content (mtime) and the inode metadata (ctime), and any
> write also constitutes an access (atime).  If no RTC is available, the
> timestamp falls back to 2000-01-01 00:00:00 UTC, matching the FAT
> write driver behaviour.
>
> The ext4 i_crtime field (true file creation time, added in ext4) is
> stored in the extra inode area beyond the base 128-byte inode and is
> not modelled by struct ext2_inode, so it cannot be set here.
> [...]
>
> fs/ext4/ext4_write.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> @@ -21,14 +21,47 @@
> +/**
> + * ext4_current_timestamp() - get current time as a POSIX timestamp
> + *
> + * Returns the current time as seconds since the Unix epoch.
> + * Falls back to 2000-01-01 00:00:00 UTC if the RTC is unavailable,
> + * matching the behaviour of the FAT write driver.
> + */
> +static time_t ext4_current_timestamp(void)
> +{
> +     if (CONFIG_IS_ENABLED(DM_RTC)) {
> +             struct udevice *dev;
> +             struct rtc_time tm;
> +
> +             uclass_first_device(UCLASS_RTC, &dev);
> +             if (!dev)
> +                     goto fallback;
> +             if (dm_rtc_get(dev, &tm))
> +                     goto fallback;
> +             return rtc_mktime(&tm);
> +     }
> +fallback:
> +     return EXT4_TIMESTAMP_Y2K;
> +}

This copies the RTC lookup from dentry_set_time() in fat_write.c, and
patch 6 adds a third copy in test/dm/host.c. I suggest a small common
helper, e.g. in rtc-uclass.c, that returns the current time in seconds
(or -ENODEV). FAT could convert that to its date/time format and ext4
could use it directly. Then the Y2K fallback, and the RTC
memory-allocation issue that 6/9 works around, are handled in one
place, and the next filesystem that wants timestamps can use the
helper too. What do you think?

For kernel-doc, please use a 'Return:' section rather than 'Returns'
in the body.

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> @@ -979,7 +1012,15 @@ int ext4fs_write(const char *fname, const char *buffer,
> -     /* ToDo: Update correct time */
> +     /*
> +      * mtime: last data modification time (ext2/3/4 spec 4.2)
> +      * ctime: last inode change time - NOT creation time despite the name
> +      * atime: last access time - set to now since we are writing data
> +      *
> +      * Note: ext4 i_crtime (true creation time) lives in the extended
> +      * inode area beyond the base 128-byte inode and is not modelled
> +      * by struct ext2_inode, so it cannot be set here.
> +      */

ext4fs_update_parent_dentry() changes the parent directory but does
not update its mtime/ctime. That could be a follow-up, but please can
you mention it in the commit message so it is clear that only the file
inode is handled?

Regards,
Simon

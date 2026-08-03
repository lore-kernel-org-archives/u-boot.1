Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF3DC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 12:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FD8160750;
	Mon,  3 Aug 2026 12:20:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mX6bm5jHbLGT; Mon,  3 Aug 2026 12:20:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CABCC60779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785759613;
	bh=Jb0ByF1xY+gdCNskKV4hybytBvhNAMyaXC+7IFEIxrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ijuPg59jnOih1PL/Du6H2SR3ylN61WvofaExA10cnK6gaZwS2/L9IbPHDTFl7xpTw
	 MUyYJ18DiBO4WLk7WtAahAFG8HJ8gEPw8ju00Mib4zzaWfKjgWGjlWuog1u3XB/FCO
	 Adfdqb2uhUsrE5avmG3+uvGKm1uNa2fIARylYr7yvjPeeck+FYJNlt1fc6tTWmz094
	 MA+9nZGiu0aHcxmfwo1ctk+rP7uxxR7fI0LvrxyrThP79gZxtXlmA5BWJLW7GqGGsz
	 T+rADJJNWb9QAORreUJ38qcCfiVZEmFTe1kxmtri/P0jOR+NrY4N6ka8gOSfEjU+lW
	 btU7fIqgQBl4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CABCC60779;
	Mon,  3 Aug 2026 12:20:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CF97836E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C188B6076A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:20:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wl13rUGK7I00 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 12:20:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DCD8A60750
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DCD8A60750
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCD8A60750
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:20:10 +0000 (UTC)
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66843536f94so3665420d50.3
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 05:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785759609; cv=none;
 d=google.com; s=arc-20260327;
 b=CbaGrcYES7ecCnYN5B9tvwppmB0v0YzjV1pH/Yaf9yQ/9p1hx6SwJnBrSe/i//j64l
 FOEBf6DE7swicUXuCOGkXEpf8Was5yE+T6tkwnyGS5naBQt6B78GGXKAf7IW9wJzbH3v
 6iZhj5TwU0kaq/0Oz9H7kUERkmtIJIBdJCgTNVH7xqSQEBOISFXGDJli0ZvVZktjE3RW
 GzQRpBLmuAa8GiyaZnt5lkR2ddRRECz24U5eu3t4uOg5nqah8bzE8w9Tod3IMPq/ISpt
 11GUKUTREmK3bkG0nhcGUS4nvNv6sQs6kiEUJ3FZ5rro+Ur+uYOsnFQah8D6dTtwfRyQ
 Juzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Jb0ByF1xY+gdCNskKV4hybytBvhNAMyaXC+7IFEIxrA=;
 fh=f/vaMyCG5Qv74UFk+AVmTQso3cXkIgLTJex8Yll2TDQ=;
 b=M9KNPRGI6eFO81GpGdD2F4HwTrdu9N2kYidASOgJiSmauan1Nj+8BMbhoZ0ZAQvDXy
 MYXa/PeFkKF14Fd3wuq6XqB8rev8HHqK1T2ydKbq2cJlR+V5h7WTBvHs2JnklCNFQV+m
 TVQOWecJxGANXlGmM+yUecLqyz31KutDY6FyNtg96YgMpF+hzarTdw3oWyaYbVfSvdVo
 jC0JgwgD0bsxk0O3PfLQzuIkXPuKXG2qs8TPu1tjma0JAypsxn9tFxpyCTknx8tFRJrM
 k8TPcvHU8ba3jsKrPrqDseCpz5Zp4s0i4Xhiz1gV5eZeK4JdsMHUemtV9COUQs62o+hH
 TEUg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785759609; x=1786364409;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Jb0ByF1xY+gdCNskKV4hybytBvhNAMyaXC+7IFEIxrA=;
 b=maHxfbVvgxXgVAm45cdBOwWJ/HmDWs34nOrM8dIWPfE0ssAVNII8zXLXQtt5LnxDzn
 UA1bsn3eAyaPG2uHf6e+mUnv6bSsqwMIGTSaAeDzW6hJKZRl6dX3Xz+demCdKZuJ7FIc
 F4QXbC0GfnUN5EbnJWei4Ln8PQ1X1FRgD74ICoK6ghoZtEuf7kq13mTPnUdYlWUKdUix
 MqgR4A4lFl3MORXA/qmgYE0/Ayezb9PWINMldCRoVvV+dZLqFYZqjLewsdHes8kBAYps
 3UJ5dx/+ALld0NScLRNCEMfn/uPNu64LO0jZ+QK1L/joyJh2TZJklWxEKsFlnwD1bew8
 241A==
X-Gm-Message-State: AOJu0YwBysMwSOB9SwkBiMari3s/m6T0L3qeCVxrzZUFJ7nyTOLLqgEH
 1NEIS3zd7sKWCzikJSzZVEJbZw0tbTGjcqPB/Akiv01pCdAID2KFaWDcvMk7GXTpaJBKpPZV2/u
 YhCgJKEKzlFPYf7ilRKTWFW/YUiixF3kmZ+DHZemtsg==
X-Gm-Gg: AR+sD125ycjUM/F1QEL+VQVopvpxtsqEQCDnF4+N7ffBKXKzw/VUw8lWUKx6qIC/Iyn
 XA4XS7umMDC90G/o4BEBQSJgAku+fEQ4jtNQ8Bq0PTtyqg1OSdNeqNZ8ItnxNpTi2ubXpR7S/yf
 zYgpSCG6/RKufgUlmpVXCQ05RBPExuDYFpo2VfdNFyGkkrzXGCJHYIofVFMtnhZqBtYuZbEuh3A
 rT4SaQwArtSEwG13rltCzok/H9oFYbtDA5foZFzeVI7JbW/Lr0517Id+lnS2E2IHk4wMa4W9gnp
 zIkvIU/5Re7T/rSHxJRoISY4JQU73slaDRYm1Hqkw6vIyUKvDL45947CILnWqQmu4PLfrpOUzAJ
 p4UjlekWD9Pt3O2Bb1Plj9RFHh/hjxvVk6z+uL8DggqHJNGK6kGaboTz1t5OOH7ep3uDR+fhdPH
 ei+tlYyWAJlAyFDZKMsB5eTGAqxIjaPdJky5wHCOjPFZ4rG2xgY0c+dQGEuYOku5uUPkXBg5S4S
 /UihG+m5LuS6JMgP6AqPfPSh1HXoLJFkcdKYnUxF/Ee7B5CNJFnZh7Ny7FMJEe+0XrpVVH1XZZd
 oeHEjP7RpcyFCG9jC4SchxtcrBiSCCpE2kR68RXJHqI1wSU3BxrtNjJPaMjKbty0gSrPby10et8
 Fty059cslpF1+og7/0/B859DEt4on6cJkB1ZinlSHAlk=
X-Received: by 2002:a53:dacf:0:b0:667:5960:a594 with SMTP id
 956f58d0204a3-6694f26980amr8756814d50.54.1785759609193; Mon, 03 Aug 2026
 05:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Aug 2026 15:19:32 +0300
X-Gm-Features: AUfX_myBMvU5sj4EcFbIciQuBU18vKOHMqmNOcYQiaSe3dNYQuUlnrEE9kgcxz8
Message-ID: <CAC_iWjJniUgONw47_WXAZZRsvrT_y6SJTyMLMOa+Hn9zy5BeFw@mail.gmail.com>
Subject: Re: [PATCH 2/6] disk: part_efi: Add missing endianness conversions
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Jacobe Zang <jacobe.zang@wesion.com>, 
 Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785759609; x=1786364409;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jb0ByF1xY+gdCNskKV4hybytBvhNAMyaXC+7IFEIxrA=;
 b=mkr8MTmLywkQIwaE438V6dS7w3PA3pUMiId4N0R4UA+4HNryEEJa/A7BeIQej2lFaL
 M+oG8R63kTHeK+ehD5/v8kFN69i8VC/wbYrv7+13nYslsP6GYEkpqBn+vyLHw9YrobkR
 9xpLlRnCHeof2Cdr01MInM8yjK3RsBOGyk8ygEk0o+GayLBrr10Lc9+H1pFIANAk0lRo
 /+uWsCUnV4Q8BPT3xxfV1AG9qBN8+ayFJVg+gYUseeKj7HyN8bYKV8Pgj8hZvuI6gFzY
 +BrQc8ieMnMUa+tNr+jPkZ8l3A3Vh0VIQPFs4EAJwTCvvAm9thAuCeG5T19uS8dJ9uA2
 A9ow==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mkr8MTmL
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

On Fri, 31 Jul 2026 at 15:40, Alexey Charkov <alchark@flipper.net> wrote:
>
> Several GPT header fields are read without converting from
> little-endian, which is wrong on big-endian hosts.

Probably because we got no BE architecture running EFI.

>
> gpt_fill_pte() takes my_lba and partition_entry_lba raw when working out
> the region a partition must not overlap, so on a big-endian host both
> bounds are byte-swapped garbage and the overlap check does not do
> anything useful.
>
> gpt_verify_partitions() compares the loop counter against
> num_partition_entries raw, so its "More partitions than allowed!" guard
> never triggers.
>
> It also swaps gpt_part_size, which is already in host order, having been
> computed from two le64_to_cpu() results a few lines above. Drop the
> conversion rather than adding one.
>
> All of this is a no-op on little-endian targets.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

In any case it;'s good to have
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  disk/part_efi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index af311867a285..062389c3af0c 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -462,10 +462,10 @@ int gpt_fill_pte(struct blk_desc *desc,
>         char *str_type_guid;
>         unsigned char *bin_type_guid;
>  #endif
> -       size_t hdr_start = gpt_h->my_lba;
> +       size_t hdr_start = le64_to_cpu(gpt_h->my_lba);
>         size_t hdr_end = hdr_start + 1;
>
> -       size_t pte_start = gpt_h->partition_entry_lba;
> +       size_t pte_start = le64_to_cpu(gpt_h->partition_entry_lba);
>         size_t pte_end = pte_start + gpt_pte_blocks(desc, gpt_h);
>
>         for (i = 0; i < parts; i++) {
> @@ -851,7 +851,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
>         gpt_e = *gpt_pte;
>
>         for (i = 0; i < parts; i++) {
> -               if (i == gpt_head->num_partition_entries) {
> +               if (i == le32_to_cpu(gpt_head->num_partition_entries)) {
>                         pr_err("More partitions than allowed!\n");
>                         return -1;
>                 }
> @@ -877,7 +877,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
>                       (unsigned long long)gpt_part_size,
>                       (unsigned long long)partitions[i].size);
>
> -               if (le64_to_cpu(gpt_part_size) != partitions[i].size) {
> +               if (gpt_part_size != partitions[i].size) {
>                         /* We do not check the extend partition size */
>                         if ((i == parts - 1) && (partitions[i].size == 0))
>                                 continue;
>
> --
> 2.54.0
>

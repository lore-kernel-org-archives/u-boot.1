Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE554606A323
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZasWSFd6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NnZyVVzV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 985E3808D9;
	Wed, 28 Oct 2026 10:23:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7whhfHjcjrUS; Wed, 28 Oct 2026 10:23:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E26208081E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793183031;
	b=fxmjbm+YjWbLwI3f9rqhjZypyQVWKuSdkruEpIFIKcLbHxtsmRc19u2mD9OjFmEsWJNF
	 mSTGbr8ukyVUjllvvi292SkJvs11GwWzDsizjQEpYqs5w13aAA1+GnkzZWAj5U/Bh6zcD
	 2S0xEyTkaWJvXIJOO68q7Mu2CPjug/sNeVLVpMg0TArSXdAa6bQKvWDI66WEN5uomNwYZ
	 AXyHsm+tqhGmponYbMkLscVn4SMAEakSRpSDW4+/628zXWLz8HkUc9EQFPXU14QGcg5A1
	 MBarle37SWLFJczuln0OMhXSOs6oJGHJhM0P8JX9DvnkbZ+rMCqY0ZnZbQJn7e41HgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793183031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+ub0ziKV4EHa5JqKC0d+iLJDHqopLWzDy5I3pcHgEuI=;
	b=n+Cz9IsURUVXljFiBk0ttfAQeJcdJzKaW7lFpwb8+BtHSK3LHYOY+8kMNTIhPI/DJX6n
	 yFmhsuaY0c4ozv/lcRdDUY7EHf5yqSJj8JTQYtnPg4qnfncoBMaeGbV0gg/Qe3SSiRuPq
	 v4YYMxidYFGAtub0lXlTaQRuUaAzAXax0SNZAhsXPucs9kYWMmmNn381QmBQE54X/ZzmM
	 NHC+FHAvy9XJUCj6c0q5lSNJMkYvrS+ZTtRzJ0dqUe7D6AaQVoF5tsZoSg1YqHTHAjBNG
	 h1T9f7pqxtNfezeWWL03PXnUGx6y+FrTSYA2C4GU9xFiyAQ3We248iS2yoECDwt5jLQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NnZyVVzV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793183031;
	bh=+ub0ziKV4EHa5JqKC0d+iLJDHqopLWzDy5I3pcHgEuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZasWSFd6E5u0Rmj5DgtJEkOTCiA4CHkSXwheRIIkp42NDMI3A1lnr2ytRWTRpKwMI
	 z+C99MPp5ZBH9BLhTTgKIvP1MohS8W1qRDVScUUGkgWOsmXuAEu6F1YjIuhC1JfDZv
	 y89nTBc7WSrwsEcgnlWWh9AFgLdgAkS6faV99YXCDKLMJxXWUfhKv4kL/I0oZAZKbX
	 P8M9zht0Itk2yBEx0ZdCucQqzotuEzVTb67vlcnEf5XJrXHCDKA9BWzm6JAPSWiZo+
	 mip1BUKzu88xb1udDXyxCMloz8EhakNC6IKuWLi7PzqUg6g9sG0k2x3CWqCyN3iz0O
	 7ecAKolzoqlIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E26208081E;
	Wed, 28 Oct 2026 10:23:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ABA9A356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D69080818
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:23:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VhOCdhIc0yxc for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:23:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A080807BE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793183029;
 b=ewyPU7RmhVuPXKAm/pd6SOknq+tgxFu2BgLzBwZ9MiSuz8phtZxHJ/NfoYr7uUWylJPI
 vKwfB1vI5utbo4OoTzC1rEj39NQbPvIOJtoC2xBAqSprlGoZUBZ8hAkbUNWoo8VGOSBMp
 OMRx8t4PppxDdEMrr31as+qIFpMJco+1y1/VJl0mdA9oU6Urc48eS8dnuuGBjUqGd5i+a
 L1hIumut5KhOLlwVXROWSEQtcbQ5AgUV/TIhgR4/3Yo6EFL/PcRwD7CT4k5oTrmv0NVl/
 0q5VVTP21l98vcd4foufGCh3iqwGIcd41ahQjXr4jh2rxHR/XbcLyjfKbIKn3VqF8aw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793183029;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=+ub0ziKV4EHa5JqKC0d+iLJDHqopLWzDy5I3pcHgEuI=;
 b=Qqv8PZvrb0GQJ1HpjeZagicyFJFkMK21Sv54ejIPomLFgKCN5OxqUJ9lKqr2613xqbpO
 6u+PKsKlWSZepBQOpK06CDVlXlT1I/J//V2inwN4z0jgg7HmzDSShl79cPuVdacf1PEdD
 LyI+Tu1h9ka6GczgjuT/SrLT7ug8SQXqXJn/xF7/RpyMPs6sjB4h+4lBZ6etKnxfchjg8
 vGlaPgSWx3ILEBOh1NvxCGKiMb5h9zhm+QhSSnrWHrbXyYoSUxqj/AC4VtF87Ctj5k0pm
 B2my4QwgqUNxAvUVRDfaGMCvggxduQFPxF+uY8w4cGdyLj6lXgsGoAkPpoT19NowxsQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=NnZyVVzV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=NnZyVVzV
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A080807BE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:23:48 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ae2b7e1e17so483034a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793183028; x=1793787828;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+ub0ziKV4EHa5JqKC0d+iLJDHqopLWzDy5I3pcHgEuI=;
 b=NnZyVVzVE1xdX9QuzwrIYj9vNs+WIbhGzcHRBSfUGGRXVZ4J8ZRBcVW9ei5/CHpNQb
 Y1vmuYetRrDSjtJL+8Ta3syxxHJWynpLVmpObqlC7xY8p9u6otTPjo3apH5xOw426kwW
 2q6fCGeJw6nHwmvK5eD6mXLzOUlxHjEUO7JDJ2wLWiG67CjR7zG1Sy0wihbUGf4yPNaQ
 L2Ux1Xnd+eIMLMYLgG6Wxo9zV3IJyfqGfGyqV1kbnU5mfLv544lxfGSGIUYG1orAyX5J
 UFC+gO8/W7JqmD6g+2JuwUVkxZELFSZCp95CTvUuc9F/6oW8l6hqwkkWMx+JV4rTEKIJ
 yF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793183028; x=1793787828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+ub0ziKV4EHa5JqKC0d+iLJDHqopLWzDy5I3pcHgEuI=;
 b=21sC5OwsZ5aIaqDlkrHWDELMrOFiz7vhAdHZtyXyPAGATX54V14ra7y8ps4eQ2ZNTC
 uZy0hBqucFnMpMpz1TavJS3H6WqxrIgZPC3HgjkcG+lBIWpj6QLx1/GI6I6zdr7fC8Cr
 Mb7f22cS5EkwhJIuAwvRaaVsIcLj6qxwc8am9WMJa4Yu8qgP6EkulYU9YI100F9ONYDq
 aGmwfI1pkRE4Fnkjiwxo4snLv50PK5zAKxIfoG4weyUckADTg0U3AagnohAWoGVlxbxm
 EBt1MSSCjPVYXUpg5ojFfsSRmczBbrz5JJzcS8OJcN8xThHwHTKYk1iO/lwiMOfmHImv
 QgWg==
X-Gm-Message-State: AFq9FYLEjyr3HqoSr+R70UAHNw8pUWGMmjsOqDpfWWK9UKnL8+4ZHIM5
 ghqSTPM6+WsswRjYUJlEoMllcmb2sKXZ2wTMd2G1br5EIfYDl4rbT7Sc1X5PVmki
X-Gm-Gg: AYBFou3hhG9ZBcd02OZ3/A/gHV0OpssqnFoUjAcEptRTONGZIYJ/2dtbvb0R4HkoKO1
 Cd1Dksn1uFFRrpx0vK8Q0qDUACQyZHeryU2+rMniBNDL7LGdic+h3K6Uh67CmotupTS3FOgGmtB
 xqAdJvgkVeq9N+9tKMkoZ9/925bHJkwDfWgKLeJVjCuw3LjYt5Oed2AO1dIoPgjvhiI2Rpoz3AG
 r4ucQcFF7fH17g1qs9GLCDPJgVYZOldaDbK6a04QekdfPn09Kj44edq2UJYIIriL4O3TH3Xt/Vw
 fchExbaTkr5C5hPvhLW5UIAcCmFLe7QqcbttqXTMNynAz0p6TsR4Un2LvfEzUjz1B8zVpUzasOD
 njYE0AzZni6xGuRhCf5U82hFVzobwl+Bck6QVnZFgdJsRT2m9/JI/guZarGmnX9ztV6rJho2LtB
 8KR4WDSvETzS3Sstmic0r2uTzw4YbMc5M1Y6S0VItQndALL5vStIkvm/0qyKsWyWyY1MqMgTk8x
 yG6a2c47AeKRTC5d4dc7SWcRXwKZg4bjAEcPTmmwI4W80BraW6K5/cZ7dOuqkH7HBYsnY7GQevC
 RL0Bbpsc828tX02NbgfXLe9dwzauaOFYgDY/bFBRZ59fvbmNQ5HdkvLb00TxbRMYraF0AUsdZlG
 O/yEjTyjuJW6GttTH0679KPOxrZ4lBprN65S1fxndw6STqu8+/zGYnta18LOm6sAiEK2aHHAu9H
 oswtnmAxdD
X-Received: by 2002:a17:90b:17c3:b0:39e:6c68:c77a with SMTP id
 98e67ed59e1d1-3ae58305438mr1468904a91.48.1793183027851; 
 Wed, 28 Oct 2026 03:23:47 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a0482e9sm2621117a91.0.2026.10.28.03.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 03:23:47 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com,
 visitorckw@gmail.com, xypron.glpk@gmx.de
Subject: Re: [PATCH v5 0/5] virtio: Add a virtio RTC driver
Date: Wed, 28 Oct 2026 18:23:43 +0800
Message-ID: <20261028102343.1747940-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFLszTgfq0uw2pPqW4Q9N_DFnMnUYONngFqO=0phfLaM7_z5Rw@mail.gmail.com>
References: <20261028030714.1608977-1-alan.tseng.cs@gmail.com>
 <CAFLszTgfq0uw2pPqW4Q9N_DFnMnUYONngFqO=0phfLaM7_z5Rw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

On Wed, 28 Oct 2026 at 16:43, Simon Glass <sjg@chromium.org> wrote:
> Just to check, is this right in practice? The 'date' command uses RTC
> sequence 0. The ARM and RISC-V 'virt' machines always provide a PL031
> or Goldfish RTC, and those boards imply DM_RTC with RTC_PL031 or
> RTC_GOLDFISH. So with the default configs the virtio RTC is the second
> RTC and 'date' never reads it, which I suspect is why you disabled
> RTC_GOLDFISH when testing. On qemu-x86, DM_RTC is not enabled in
> U-Boot proper, so the driver is not built at all.

You're right, that sentence overstates it. With the default configs
the virtio RTC is only the second RTC, and that is why I disabled
RTC_GOLDFISH to test it with "date". On qemu-x86 it also needs DM_RTC
enabled.

> It might be worth a follow-up adding a sentence to the virtio
> documentation on how to reach the virtio RTC when a platform RTC is
> present, e.g. with 'rtc dev', or with an alias if that suits your use
> case.

Yes, I'll send that. One thing I found while checking: "rtc dev 1"
selects it for "rtc read", but "date" still uses sequence 0. An alias
does not work either, as the virtio device is bound by the transport
and has no node of its own. So the doc would point to "rtc dev" and
"rtc read", and say that "date" needs the platform RTC disabled.

Thanks,
Hung-Chun

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189EEC3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 23:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4E0886516;
	Thu, 24 Aug 2023 01:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hk0r0cgN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB91786527; Thu, 24 Aug 2023 01:59:22 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0382864F9
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d7801f1f608so65622276.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CTBm95/Hj/+bthb6z47s5+//eB1/elD2H11m1oxxaeY=;
 b=Hk0r0cgNb+8IXMhHHQ07GUBLE8NCWBI88UVAm6JGnWgJcFGY/KwX5pkpDv3Qi3Regt
 0trC+fqdkuUsLEFdLH7RdukDdEbzx3ANZa5rbwKFAYC8CjomuMY3S+ucygVJifAJB/Zv
 5TKnSfMCdb0PvAihGfwALrn3KWMGaZQfSPjR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CTBm95/Hj/+bthb6z47s5+//eB1/elD2H11m1oxxaeY=;
 b=K1bQKi2mCzjCwpO5AAG4jzUUUYMDlE7gz7gjR52s0TRIo9gcH8G2/pUYYzsNQ7mhJe
 BpXLUSieBTjxbh/7ThugQ+vkXGSTf9KuB3c9DMM2NM9Zi8Vv/YDvbrSqpLKvnEYoaOAK
 U+1Lz4r94uXLGtnU15FPcxljuwZLM52+T7OdtdOxImr+dz4/1mwDo0c/zq8d4++F/q2N
 LeEolAz5pON+d3GTHTcpFbjncRSu1mLC49gQSaxZioNmonMBYnOmp3gcCLr1t/Bkw5OR
 BohczsTGH91oluUV22+LlkmshD3Aw4r5IEddulzAP7jT9na0MhPTVn7drsqBjRs4HmRG
 Pe+w==
X-Gm-Message-State: AOJu0Yxegc6RPCIg1l+UeD/iI52i7EN8JDnprcE2oEv46l+/qoOY10+Q
 Sg9yPRLJmgiBsISJbayeMs8Ei9VBLZiZQZdBOWZIBg==
X-Google-Smtp-Source: AGHT+IE1GTdYHVJZheuzBVtMNohgZX+A1ivqHgxEiLIgquw4cEgKFhluFRcI+lkyclEiIvUWbGu5hrAiPd9A6K7Yeuk=
X-Received: by 2002:a5b:a48:0:b0:d77:ab03:7900 with SMTP id
 z8-20020a5b0a48000000b00d77ab037900mr4222469ybq.15.1692835156440; Wed, 23 Aug
 2023 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-4-JPEWhacker@gmail.com>
In-Reply-To: <20230823164755.2874792-4-JPEWhacker@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Aug 2023 17:57:41 -0600
Message-ID: <CAPnjgZ3Zorddu5krWzPjdZ34LcDUgP47PLmWGZp1MRDpYxG9mA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] tests: gpt: Remove test order dependency
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Joshua,

On Wed, 23 Aug 2023 at 10:48, Joshua Watt <jpewhacker@gmail.com> wrote:
>
> Re-create a clean disk image for each test to prevent modifications from
> one test affecting another
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  test/py/tests/test_gpt.py | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)

I suppose this is OK, but is it expensive in terms of time?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon

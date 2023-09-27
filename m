Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D26E82CBE
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 18:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B340886A0A;
	Wed, 27 Sep 2023 20:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O6uRQ8EA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A93D086D59; Wed, 27 Sep 2023 20:31:30 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67557869CA
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 20:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=troykiskyboundary@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-564af0ac494so7843487a12.0
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695839487; x=1696444287; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nmzm3XNjDBrFdF/AURIi36gghtq0ZmEmBAYKA+oy8v0=;
 b=O6uRQ8EAxbHiCwNMGWIsHsKVtd28kf/3g0xt90mrDA2LPcUm+8xUM+R35+bA65JfY9
 sW7BZjWP0oxOZ/e+ya5cIrU+zsXyQvpLMbBmD7Kh65YMqsPuP/3i/JXdCeBVMLVtV3iJ
 m9b0GnE9y9mXMdspvib4lUbNv65polQ826KeaIHZKy6J6Hp+w9jgNlAPnNbMiYLkBiZh
 Ph8D7+1lrVL7iQzN5yPTtTK8oTJKy9dLWOFn8Q7oanWyEtTAbhlA5OjGPNCcz2PP5BYb
 89YBSzbLRBLDg1frlbXA3vB2PYwKndw8ASt76bSdXxV5fu1MMrV66/Hyayz7/5m4IXVL
 d/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695839487; x=1696444287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nmzm3XNjDBrFdF/AURIi36gghtq0ZmEmBAYKA+oy8v0=;
 b=mmNS8eMoS4AkOQJRMH0TNF2d663nSLMkIxnjkhp/pRFtYWUnxbfxCyBhvU1Lc4KHWd
 pmNGrVKd2Qk+9NoRugc8ZaSataiEm7cm6dvTo1H5+jfG0+dSkZEc+IbUBvD/xTjAJCr6
 OlU8BO6cRCwoSUEJosgNZi7Y7GVMmFbVgu71h8lfjOec09HCM/CQ+/HHiONBxjo0FimI
 GUc0btkNzqrb4+HUwxlwR494izBdUqA72a/vVMvyAXKStNv8zoCpgf+pc1SVgn9ka/Un
 JkWLrc2Hy0bfZFKJiRs/MU2FMBjEtsjLU6WnvXtDVmuIMsR8ca9kCXfa4rtKBNolSW8s
 hkvA==
X-Gm-Message-State: AOJu0YyLK6NdtpAmMKbLh32vV2z+HOmEs1F1IvA+Zl/SgjFa/few0r5d
 nIqK4iUtYlK/BlvJVglQBhr6t4n7XsPyXOXu474=
X-Google-Smtp-Source: AGHT+IH6zfMo1+Q6+SPJzDMVg19212sEPr9Hiju1RAByuFgKpSm6cgEyinEdukiTVgKoheUU57KeDye1puKhvMrIbMg=
X-Received: by 2002:a05:6a20:728e:b0:137:3c67:85d7 with SMTP id
 o14-20020a056a20728e00b001373c6785d7mr3026389pzk.16.1695839486620; Wed, 27
 Sep 2023 11:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230619230655.2406929-1-troykiskyboundary@gmail.com>
 <20230619230655.2406929-2-troykiskyboundary@gmail.com>
 <CAO46J5W1-7JdoGddMqUHLfv9SyLzzpR+MXA8O8cevwfheV4AjA@mail.gmail.com>
In-Reply-To: <CAO46J5W1-7JdoGddMqUHLfv9SyLzzpR+MXA8O8cevwfheV4AjA@mail.gmail.com>
From: Troy Kisky <troykiskyboundary@gmail.com>
Date: Wed, 27 Sep 2023 11:31:15 -0700
Message-ID: <CAO46J5VkExr2v7RGPUHivmxG1mAthR5nKpUX+NJjyRh11pPfiw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] CI: add test/usage_of_is_enabled_check.sh
To: sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de
Cc: gary.bisson@lairdconnect.com, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joel Stanley <joel@jms.id.au>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Peter Hoyes <Peter.Hoyes@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, Sep 27, 2023 at 11:14=E2=80=AFAM Troy Kisky <troykiskyboundary@gmai=
l.com>
wrote:

>
>
> On Mon, Jun 19, 2023 at 4:07=E2=80=AFPM Troy Kisky <troykiskyboundary@gma=
il.com>
> wrote:
>
>> Add script usage_of_is_enabled_check to print any configs that
>> use CONFIG_IS_ENABLED instead of IS_ENABLED and vice versa.
>>
>> Add usage_of_is_enabled_commit.sh to generate commits to fix the above
>> issues.
>>
>> You can remove entries from test/usage_of_is_enabled_todo.txt
>> or the entire file and then run
>> test/usage_of_is_enabled_commit.sh
>> to convert to suggested usage of CONFIG_IS_ENABLED/IS_ENABLED
>>
>> or run test/usage_of_is_enabled_check.sh to
>> see which configs are still todo.
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Troy Kisky <troykiskyboundary@gmail.com>
>> ---
>>
>> (no changes since v1)
>>
>>  .azure-pipelines.yml                |  11 ++
>>  .gitlab-ci.yml                      |   5 +
>>  test/usage_of_is_enabled_check.sh   |  19 +++
>>  test/usage_of_is_enabled_commit.sh  |  12 ++
>>  test/usage_of_is_enabled_correct.sh |  50 +++++++
>>  test/usage_of_is_enabled_exempt.txt |   9 ++
>>  test/usage_of_is_enabled_list.sh    |  86 +++++++++++
>>  test/usage_of_is_enabled_splcfg.txt |  21 +++
>>  test/usage_of_is_enabled_todo.txt   | 213 ++++++++++++++++++++++++++++
>>  9 files changed, 426 insertions(+)
>>  create mode 100755 test/usage_of_is_enabled_check.sh
>>  create mode 100755 test/usage_of_is_enabled_commit.sh
>>  create mode 100755 test/usage_of_is_enabled_correct.sh
>>  create mode 100644 test/usage_of_is_enabled_exempt.txt
>>  create mode 100755 test/usage_of_is_enabled_list.sh
>>  create mode 100644 test/usage_of_is_enabled_splcfg.txt
>>  create mode 100644 test/usage_of_is_enabled_todo.txt
>>
>>
> If this patch is still desirable, it can be updated by
>
> rm test/usage_of_is_enabled_todo.txt
> test/usage_of_is_enabled_check.sh >test/usage_of_is_enabled_todo.txt
>
> And delete the last 2 lines
sed -i '$d' test/usage_of_is_enabled_todo.txt
sed -i '$d' test/usage_of_is_enabled_todo.txt


> BR
> Troy
>
>

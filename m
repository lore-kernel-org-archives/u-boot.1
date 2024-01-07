Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF37C47074
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 16:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70D0787A06;
	Sun,  7 Jan 2024 17:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BSMxJjtf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83F4A877FC; Sun,  7 Jan 2024 17:36:27 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D94F877FC
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 17:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-557535489d0so1169766a12.2
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 08:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704645385; x=1705250185;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfHifqQsp8RM7p6WXGLqV5ojDTH/adlHLdXhGvVNzeg=;
 b=BSMxJjtf/7uwGezVzYawWM3qmf5TWVp9x3sws3xLCl67WAHUK03RUkdUchVLhAlmRW
 HGlVXC1CVyax471X5ywXM3wGOSp3sGZ2jsRMKsnG8LsdMM3YNjUdrChMGPhl1+s29tw+
 HQEYzcXRxXsH1xqXvX6y1Vh4ych7ZMxKBK/B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704645385; x=1705250185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfHifqQsp8RM7p6WXGLqV5ojDTH/adlHLdXhGvVNzeg=;
 b=qV3qYto0BIZzaPdqirhagERFJcmiAnjZGpjo1syfPJK7LXQkfJvLiWrGg5vt3fCG9n
 K05s0sIoohc28uC+s6pn7XJFazVnENKIlZk6BHoAwBR4F8FQnU5sCornPD85YKevIK4o
 O2+CkPxRovB5FdwHloCZM1OUQqirJZInjI6q+gOYWFwLNQFY67/JsKEabUQw8mBA+VB2
 ZcNMGexEVif8tfl/k3IN0rBjVsi9+XHWYyE90+e2uZEZCLoDl4oBA25HgtoOuK15DHBS
 bWvfw2axWZZuxppjqU42wuwpNRd9TM6hUqu3U6AfD2Y1ZJGIEDZPbi+GBN/askMPqNCo
 j5xA==
X-Gm-Message-State: AOJu0YwIwyHdk7UnQNXMCospkOKZttqeR5ArwMWjhfI5/RN0nuFnENVC
 rHH0CDjfrSZacxXRdAhXN1F0oIhIyrOiwW72jb3alofvkeEvlQ==
X-Google-Smtp-Source: AGHT+IHgU/MKIG5Vba9FsNN4hpsjUGbMLe05tozWQanLWpnAX3AEtgoIB+tLlgX+zaCYgnn4Jbld3Tq8M5ycFBZLiqY=
X-Received: by 2002:a17:906:187:b0:a28:f817:f46a with SMTP id
 7-20020a170906018700b00a28f817f46amr965272ejb.6.1704645385045; Sun, 07 Jan
 2024 08:36:25 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
 <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
 <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
 <CAOMZO5C4qF4A8uLdRfMeDVosA2NLNU=+WvidGR7QGeSyYJOTmw@mail.gmail.com>
 <CALG-KHwHxdd_7wz6L+6VDGS04LggyqhTZUoqgV+euSqPn9D2KQ@mail.gmail.com>
 <CAOf5uwmDZ5DtAhe-GauhuyYwSSXQnavVNfzaJkdSG3TWE1N2FA@mail.gmail.com>
 <CAOMZO5DtCDe-VzY1yx2f+LTz0tCqmtiLemrH=xTnPQs7=07aSw@mail.gmail.com>
 <CAOf5uwn1LuN6uFQe9d7zXWDFnvOAqwb-etQow96fzAR0qim5Hg@mail.gmail.com>
 <CAOMZO5AqatVOGsJGwxXJCoF+tBemrfM8+pgrRCvDwHNHv1caFw@mail.gmail.com>
 <CAOf5uwmb0vJOwSj81KvfWpK6yobyz0Ozm5vDGCa9K0rZejbZLA@mail.gmail.com>
 <CAOMZO5Aa4ynpHqfqiAF6qAJmTJeAPQCmT4wyTz6H+UE3yX0jpg@mail.gmail.com>
 <CAOf5uwmBdtUBQbgKncLBBV0XC06JqOOKmgOrwxbt=oSZ6mhqKQ@mail.gmail.com>
In-Reply-To: <CAOf5uwmBdtUBQbgKncLBBV0XC06JqOOKmgOrwxbt=oSZ6mhqKQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 7 Jan 2024 17:36:13 +0100
Message-ID: <CAOf5uwk4U-o-KwVyDqNy_9vQA6q6Ms0JiB=pth4o7ZsEdMcz-g@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Fabio Estevam <festevam@gmail.com>
Cc: Paul Liu <paul.liu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>,
 u-boot <u-boot@lists.denx.de>, 
 Duncan Hare <DuncanCHare@yahoo.com>, Simon Glass <sjg@chromium.org>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Fabio

On Sun, Jan 7, 2024 at 5:19=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> Il dom 7 gen 2024, 17:08 Fabio Estevam <festevam@gmail.com> ha scritto:
>>
>> Hi Michael,
>>
>> On Sat, Jan 6, 2024 at 5:49=E2=80=AFAM Michael Nazzareno Trimarchi
>> <michael@amarulasolutions.com> wrote:
>> >
>> > Hi
>> >
>> > Is this code correct?
>> >
>> >     if (tcp_seq_num >=3D initial_data_seq_num &&
>> >                     store_block(pkt, tcp_seq_num - initial_data_seq_nu=
m,
>> >                                 len) !=3D 0) {
>> >                         wget_fail("wget: store error\n",
>> >                                   tcp_seq_num, tcp_ack_num, action);
>> >                         return;
>> >                 }
>> >
>> > Can not be seq_num wrap around? Another point seems that is not
>> > guarantee packet reassembly
>>
>> If you submit a patch, I will be glad to test it.
>>
>> Cheers
>
>
> I have already wrote something but I can not test. Will send tonight. My =
feeling is that sometime the initial sequence number of TCP ip is next to w=
rap around but not sure.
>

I have sent but not sure about it, just compile for now ;)

> Michael



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

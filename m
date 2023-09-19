Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165C6CD342F
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 01:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E63869F1;
	Tue, 19 Sep 2023 03:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="WaG4QnVB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AB1186A49; Tue, 19 Sep 2023 03:05:12 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C770386915
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 03:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52c4d3ff424so6333167a12.0
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 18:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695085510; x=1695690310; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cn+dG64XMs3aHg+XLGsO8RRVegwsHXAN0CSNX5CCzcE=;
 b=WaG4QnVB5TkxJeo56pP7fgEtojtF5BH3TwtVApCvcGfimjo8sZho1z6rG8y63/O4Kg
 +hPoWq1/ZlRs/13tHe3jDCWmxEKWIkP3ZY3k/uaJ9wzSMZr3+53pkNWcwpfTYqyTIhTT
 UhXVoUE9TUgVfpl/2iYxHkH9PBIRHGfFkRXyCR56kE6Drw+sARdR26g6CxnBZ01RqpCi
 /or8irNmh0zFtlEDY3nqK0XewmN9wKs1cZ6BmQusRBqgwaxj8eOZ8bPIswlDW/C1z8BO
 VEyEgCf5veHQiTgGBWSWZRo3in5qoXxLyr6nvZofgeKInuHpaa7JesXXOEtCAsUrT++4
 sqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695085510; x=1695690310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cn+dG64XMs3aHg+XLGsO8RRVegwsHXAN0CSNX5CCzcE=;
 b=G51F99mQs6onKUoD74enaYrju/YE7qaIGjUUPvWLH+ODVXTIPXSK2Qk+11TRuaJ+kJ
 uu4Goh+uN4FosbGddTnhW1OrPp5lp9H2LMhsf7Qy74KHzY875+24iVxnPSNIGtlp1ZnT
 eeexcmudwXOvwnvTuvU6QFJAckjtp4zjDik9F7njrfd94K0Yc5lnC+KT3nHCf8FV3pZ4
 G1ZPK4PQGfdaykBHXAJbO2bEKV3F8OVXcnGfekvWEBEAuiDwf6FA/ftiqocIsADW5ekh
 tup7qmjNXQf4FjKPggn3tsgEA8dxGe5YHPE2EBuK+jlevnpe0Awif/307hWPGEIH+iM1
 Zqxg==
X-Gm-Message-State: AOJu0Yydh4qKVvnPvYL+otTytWwEYvOSSA8Fsn+BAc0kyjT1Z9Md41ZA
 ySFwlsrehpexmHQHnGJSXs6115chFA/zKGYFA84cHg==
X-Google-Smtp-Source: AGHT+IHOJMpifZw9je5k13PgtJw9mkzVoCjvW01HXzUkDJvi18OzaHlvQ8di03SvUXzV+oHoAztt+CPCedBEpAJYksc=
X-Received: by 2002:a05:6402:ca3:b0:532:c08a:eac0 with SMTP id
 cn3-20020a0564020ca300b00532c08aeac0mr42225edb.26.1695085510243; Mon, 18 Sep
 2023 18:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230915221153.2767153-1-yoann.congal@smile.fr>
In-Reply-To: <20230915221153.2767153-1-yoann.congal@smile.fr>
From: Simon Glass <sjg@google.com>
Date: Mon, 18 Sep 2023 19:04:58 -0600
Message-ID: <CAPnjgZ3bQoR7W819cMoR4x0WSYx-8+1nArkCf9h6o7MXuqTg5w@mail.gmail.com>
Subject: Re: [PATCH] doc: usage: load: document part as hexadecimal
To: Yoann Congal <yoann.congal@smile.fr>
Cc: u-boot@lists.denx.de,
 =?UTF-8?Q?Micka=C3=ABl_Tansorier?= <mickael.tansorier@smile.fr>
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

On Fri, 15 Sept 2023 at 21:33, Yoann Congal <yoann.congal@smile.fr> wrote:
>
> From: Micka=C3=ABl Tansorier <mickael.tansorier@smile.fr>
>
> `part` option is in hexadecimal, so information is missing in usage
> documentation.
>
> Callgraph for `part` parsing is :
> do_load -> fs_set_blk_dev -> part_get_info_by_dev_and_name_or_num ->
> blk_get_device_part_str -> hextoul (This is why it is hexadecimal)
>
> Signed-off-by: Micka=C3=ABl Tansorier <mickael.tansorier@smile.fr>
> Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>  doc/usage/cmd/load.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

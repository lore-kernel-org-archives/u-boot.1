Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E200D3B9A7
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F30D589CA4;
	Tue, 26 Nov 2024 16:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f3fPu1X0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7377F89CA2; Tue, 26 Nov 2024 16:39:00 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C2A189C96
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso920873766b.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732635538; x=1733240338; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hoUtAE490958J5bT+kU9knKMFFPql+9BDo0GpxfJPII=;
 b=f3fPu1X0M2u+2yK5ejK9jDfTY0ETJB7emvlaptX4vqDmyizpx8pAlLJgQ9h4KRVvcC
 qPToiUYssO+f0kVdNrjuER4MMOv+T0fqysaroqwpFx3IiWAvp6T0ojZXGtcaednkcdVH
 n5D4MvKO7HmxYqS92UagwtnyOPb3OAeYrBt0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635538; x=1733240338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hoUtAE490958J5bT+kU9knKMFFPql+9BDo0GpxfJPII=;
 b=WCHGJOTa77yRVvIKH8blA3er4oaSbYTFaQBV7J4+voUBU7Y1Dtb4mJY1vzZm2lTLzP
 ME0QqS90JUwzK2Oo1HV0cUaIgssnC25B3Tn0CXwdBMkOMuDhHl+BR7b8O77bOvAKCLw0
 w6YabxjaKTs1+6gXgFV4Vs1uZmwVWOsJSy+pM+QROONbYYOxPX9ZBcsSKfkXk11Wh3TQ
 q7m2lThmhuRkUYtbPuPKWOPfjL5r5a2JpGYuvtGt5LKf5tEnacS33xdnHX7kmYaGsd7t
 bJ937y23+Epxv1K/sV14nBGlUw1qiDvyXhkCuik0Z/I17vw+e2z5yFCV6YHFSEB7Fpng
 DAQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdbDMau8ht0kxHIEzlp8Vj6wKQ/TYK6V5IYvR83rCNL30EzrRaUK/Olbe3EialNLthIs6YD4A=@lists.denx.de
X-Gm-Message-State: AOJu0YzqpGJF8Pw2R4mbs1I7iB1+4+9YbmTkksFcoKdnBo744sgs2Nwv
 GsfgJpsvtpggingEB4kqR6hDEEBq5yyZAOWInqt7HfRHpPsv3OgNU+SbVu4uxLbaygTnO3a+3Hs
 xpp9qQ0C/xddBpqiIgRKpOtypPHN7faI6QSct
X-Gm-Gg: ASbGncuhMAcvDlHCXy7V4SFPCjOSNgqof/1ch02vpgJjZe+OVh8Ys7p7hflznfvQMam
 VdLqwYKxNbDTe+oGM8e1TO3UHyxR/st8=
X-Google-Smtp-Source: AGHT+IHGE+y4LATABwVItsPjLmDr5LPKI2jhQTEiK+oo8ZenvKuF4/zFGd0xVFUngVeRcPetAJ+MSaqDPiS6OIXGJnY=
X-Received: by 2002:a17:907:7701:b0:aa5:27a8:4cbc with SMTP id
 a640c23a62f3a-aa527a84d81mr1149774566b.15.1732635537925; Tue, 26 Nov 2024
 07:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-5-heinrich.schuchardt@canonical.com>
 <CAFLszTgNguURurFAnX4W4mw8_Fokj2iCQOw15MCnFtT_zea6hw@mail.gmail.com>
 <f7706753-d4bc-484a-bf5d-f4b85205ac8e@canonical.com>
In-Reply-To: <f7706753-d4bc-484a-bf5d-f4b85205ac8e@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Nov 2024 08:38:45 -0700
Message-ID: <CAFLszTiCv3zdeg+1vNKY__iYmdZgVs4E=GXT6Y2DYCGQOi4RzA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] net: eth_bootdev_hunt() must not try to boot
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, 
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Tue, 26 Nov 2024 at 00:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 11/26/24 01:32, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sat, 23 Nov 2024 at 14:46, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> eth_bootdev_hunt() should not execute dhcp_run() as this itself would load
> >> a file and boot it if autostart=yes.
> >>
> >> Instead just check that there is a network device.
> >
> > If you look at dhcp_run() you will see an 'autoload' parameter. This
> > is 'false' in this code, so it never loads a file.
>
> This is not the complete truth.
>
> If $autostart=true and CONFIG_NET=y, dhcp_run(false) still tries to load
> a file.

Here is the code:

int dhcp_run(ulong addr, const char *fname, bool autoload)
{
char *dhcp_argv[] = {"dhcp", NULL, (char *)fname, NULL};
struct cmd_tbl cmdtp = {}; /* dummy */
char file_addr[17];
int old_autoload;
int ret, result;

log_debug("addr=%lx, fname=%s, autoload=%d\n", addr, fname, autoload);
old_autoload = env_get_yesno("autoload");
ret = env_set("autoload", autoload ? "y" : "n");
if (ret)
return log_msg_ret("en1", -EINVAL);

It respects the autoload parameter. If there is a bug in that, we
should fix it, but it seems to work OK to me. Please fix your commit
message.

>
> In all cases dhcp_run() wastes boot time.

Yes, it uses time. With bootstd the hunters are only called as needed.
In your case you are calling all of them at once.

Is there a way to just call hunters which relate to block devices, perhaps?

>
> CONFIG_NET=y
> => dhcp_run
> BOOTP broadcast 1
> BOOTP broadcast 2
> BOOTP broadcast 3
> DHCP client bound to address 10.0.2.15 (1004 ms)
>
> => setenv autostart true
> => dhcp run
> BOOTP broadcast 1
> BOOTP broadcast 2
> BOOTP broadcast 3
> DHCP client bound to address 10.0.2.15 (1002 ms)
> Using e1000#0 device
> TFTP from server 10.0.2.2; our IP address is 10.0.2.15
> Filename 'run'.
> Load address: 0x40200000
> Loading: *
> TFTP error: 'File not found' (1)
> Not retrying...
>
> CONFIG_NET_LWIP=y
> => dhcp_run
> DHCP client bound to address 10.0.2.15 (1007 ms)
>
> Where command dhcp_run is provided by:
>
> #include <command.h>
> #include <env.h>
> #include <net-common.h>
> #include <vsprintf.h>
>
> static int do_dhcp_run(struct cmd_tbl *cmdtp, int flag, int argc,
>                    char *const argv[])
> {
>          ulong addr = hextoul(env_get("loadaddr"), NULL);
>
>          dhcp_run(addr, NULL, false);
>
>          return 0;
> }
>
> U_BOOT_CMD(
>          dhcp_run,       CONFIG_SYS_MAXARGS,     1,      do_dhcp_run,
>          "dhcp_run",
>          NULL
> );

See above

[..]

Regards,
Simon

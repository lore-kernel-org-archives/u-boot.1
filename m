Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F844EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 07:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB66F86D0B;
	Mon, 11 Sep 2023 09:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rdbgcnfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB53086D16; Mon, 11 Sep 2023 09:22:57 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D9986CF1
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 09:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68e2ff0b5c4so368017b3a.0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 00:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694416973; x=1695021773; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SrSmyX9ZA2e8h3vwINGrieOipex9QAX3maUZwA+2Etc=;
 b=rdbgcnfUYnXxRN2li79Ox8sT9v/9+p+dbZ2B3bWALLK8YpkIPqq5H0CqB2c1+6nLmk
 KtSZgLF13GNI8gfPdgDi/FUNiMFLCw0HOM2IrCtgebE2Q4Kz+S8II7Q9ZYRACy0TgcA7
 IlswYasU9V+j5hJ71rncggs0gMQQWdq7LwUHcYF7TAhnL+qjbJjvxXrUjLXYxhw0B9uU
 O+xe45zYn8U1tfrcldrQMdpztwmJYmSgTiFNaHpubcFyLeeN0WWFhUswDjPC46+3hFdr
 UjN/gG5WkebwjpPbagBduQP1RWaEHNfV45BaRTY19eZ9bLTz0hpEW2OXFO3EuJWyQZMv
 gDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694416973; x=1695021773;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SrSmyX9ZA2e8h3vwINGrieOipex9QAX3maUZwA+2Etc=;
 b=HWj7ukdydw2ixD1q+pHiY2zg4ThfX+YZ1B8ZN2g13lMBuF14pZmKDGGSHT7iNoQ0oT
 wLRdZc0WVJkmUjESChrcO/fG3dk/PICpdxeEIOGAZKGtpqGG2XdK9sBlq7b20WEIXm6Z
 LlNGOTCPQwiihlkPMsY9IypuFqdxo/Oj0z6xKDxx4ahEnjnnixE0O8kMgoXXGzys21ru
 PmxhpLxO+jNlj1YVc3PoPOi+nSl6sY2FuiMQu2y5U8H6AesRyxbWwxqoKaJbjYTzJRHQ
 fTq1zVhE2nbyKL07DfgL5FYleSgCUQ353D/XhtoE3o8BPzu1LMujZ0Qu6rxw3sf7b7pj
 h13Q==
X-Gm-Message-State: AOJu0Yytl2lWDdr1uPIqaUUQGamsacUz3cOXyaprmgPVS9jo59YzYRbn
 t2mgbCayoXoPeMmiAb/yOoiyOQ==
X-Google-Smtp-Source: AGHT+IFpLDn3szoA953sVg7iNhexEolUbwQFA2Zu1T63KkWueVRTIulHEVRUKZU+lYshl8peqtpAJg==
X-Received: by 2002:a05:6a00:158e:b0:68e:3eff:e93a with SMTP id
 u14-20020a056a00158e00b0068e3effe93amr9817752pfk.2.1694416972894; 
 Mon, 11 Sep 2023 00:22:52 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:91f5:5d19:aad:686c])
 by smtp.gmail.com with ESMTPSA id
 q19-20020a62e113000000b0068a46cd4120sm647720pfh.199.2023.09.11.00.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 00:22:52 -0700 (PDT)
Date: Mon, 11 Sep 2023 16:22:49 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Etienne CARRIERE <etienne.carriere@st.com>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v3 13/13] test: dm: add scmi command test
Message-ID: <ZP7ASf6h524kQHty@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne CARRIERE <etienne.carriere@st.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
 <20230908025138.44405-14-takahiro.akashi@linaro.org>
 <PAXPR10MB4687E186E8A0810CF1784121FDEDA@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR10MB4687E186E8A0810CF1784121FDEDA@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
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

On Fri, Sep 08, 2023 at 02:27:15PM +0000, Etienne CARRIERE wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Sent: Friday, September 8, 2023 04:51
> >  
> > In this test, "scmi" command is tested against different sub-commands.
> > Please note that scmi command is for debug purpose and is not intended
> > in production system.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > ---
> > v3
> > * change char to u8 in vendor/agent names
> > v2
> > * use helper functions, removing direct uses of ops
> > ---
> 
> This change breaks pytest ut_dm_dm_test_scmi_cmd.
> CONFIG_CMD_SCMI=y is missing in sandbox_defconfig.

Sure.

> 
> >  test/dm/scmi.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 57 insertions(+), 5 deletions(-)
> > 
> > diff --git a/test/dm/scmi.c b/test/dm/scmi.c
> > index 0785948186f0..423b6ef70b29 100644
> > --- a/test/dm/scmi.c
> > +++ b/test/dm/scmi.c
> > @@ -104,8 +104,7 @@ static int dm_test_scmi_base(struct unit_test_state *uts)
> >          struct scmi_agent_priv *priv;
> >          u32 version, num_agents, num_protocols, impl_version;
> >          u32 attributes, agent_id;
> > -       char *vendor, *agent_name;
> > -       u8 *protocols;
> > +       u8 *vendor, *agent_name, *protocols;
> 
> Could you squash these fixups into patch 10/13
> ("test: dm: add SCMI base protocol test") unlesswhat that patch 
> makes sandbox test build to fail.

Okay.


> >          int ret;
> >  
> >          /* preparation */
> > @@ -134,9 +133,9 @@ static int dm_test_scmi_base(struct unit_test_state *uts)
> >          free(vendor);
> >  
> >          /* message attributes */
> > -       ret = scmi_protocol_message_attrs(base,
> > -                                         SCMI_BASE_DISCOVER_SUB_VENDOR,
> > -                                         &attributes);
> > +       ret = scmi_base_protocol_message_attrs(base,
> > +                                              SCMI_BASE_DISCOVER_SUB_VENDOR,
> > +                                              &attributes);
> 
> Same here.

Yes.

-Takahiro Akashi


> BR,
> etienne
> 
> >          ut_assertok(ret);
> >          ut_assertok(attributes);
> >  
> > @@ -207,6 +206,59 @@ static int dm_test_scmi_base(struct unit_test_state *uts)
> >  
> >  DM_TEST(dm_test_scmi_base, UT_TESTF_SCAN_FDT);
> >  
> > +static int dm_test_scmi_cmd(struct unit_test_state *uts)
> > +{
> > +       struct udevice *agent_dev;
> > +
> > +       /* preparation */
> > +       ut_assertok(uclass_get_device_by_name(UCLASS_SCMI_AGENT, "scmi",
> > +                                             &agent_dev));
> > +       ut_assertnonnull(agent_dev);
> > +
> > +       /* scmi info */
> > +       ut_assertok(run_command("scmi info", 0));
> > +
> > +       ut_assert_nextline("SCMI device: scmi");
> > +       ut_assert_nextline("  protocol version: 0x20000");
> > +       ut_assert_nextline("  # of agents: 2");
> > +       ut_assert_nextline("      0: platform");
> > +       ut_assert_nextline("    > 1: OSPM");
> > +       ut_assert_nextline("  # of protocols: 3");
> > +       ut_assert_nextline("      Clock management");
> > +       ut_assert_nextline("      Reset domain management");
> > +       ut_assert_nextline("      Voltage domain management");
> > +       ut_assert_nextline("  vendor: U-Boot");
> > +       ut_assert_nextline("  sub vendor: Sandbox");
> > +       ut_assert_nextline("  impl version: 0x1");
> > +
> > +       ut_assert_console_end();
> > +
> > +       /* scmi perm_dev */
> > +       ut_assertok(run_command("scmi perm_dev 1 0 1", 0));
> > +       ut_assert_console_end();
> > +
> > +       ut_assert(run_command("scmi perm_dev 1 0 0", 0));
> > +       ut_assert_nextline("Denying access to device:0 failed (-13)");
> > +       ut_assert_console_end();
> > +
> > +       /* scmi perm_proto */
> > +       ut_assertok(run_command("scmi perm_proto 1 0 14 1", 0));
> > +       ut_assert_console_end();
> > +
> > +       ut_assert(run_command("scmi perm_proto 1 0 14 0", 0));
> > +       ut_assert_nextline("Denying access to protocol:0x14 on device:0 failed (-13)");
> > +       ut_assert_console_end();
> > +
> > +       /* scmi reset */
> > +       ut_assert(run_command("scmi reset 1 1", 0));
> > +       ut_assert_nextline("Reset failed (-13)");
> > +       ut_assert_console_end();
> > +
> > +       return 0;
> > +}
> > +
> > +DM_TEST(dm_test_scmi_cmd, UT_TESTF_SCAN_FDT);
> > +
> >  static int dm_test_scmi_clocks(struct unit_test_state *uts)
> >  {
> >          struct sandbox_scmi_agent *agent;
> > -- 
> > 2.34.1
> > 

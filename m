Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB8606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 04:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VnVu7zel;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=awj+6w00
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 183F140ACD;
	Thu, 12 Nov 2026 04:24:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZHV1WLTBtkkm; Thu, 12 Nov 2026 04:24:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B790409A0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794457478;
	b=Y3u56tqub/uo7Vr30bxRh830A0De/jeuIRKeaNyAe746VaGX9otfDtlxavMgWaRBFeAo
	 ojN5xZhwjAktEVff2vI0jb7Jq9219wbXPC9K2HR1a3ExWCkT/FZ6URr4XSnfjILml/3U5
	 RltO8rhSOFkkT7ka2GIMwUH8wx/1dgcVtUV9BUWTRTriKL+K+Zv/YHdsBF0wZPEWNaSGT
	 DDUhEk9jPguBJzVpyZDrLJKcyxy0A6/2ZDnLQPvVBgIwMFh2HxWiAbUv3wXJAbe1D+c4b
	 a57XnvthrgO2E9zt2uoDaftbTAqyyROge4VDUn/X1yBEBoXG9gz1+CDtiJVmEnyYiGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794457478;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zhqY3AvClzTF/3fBqtg4yRX6p4Q/NNp6yltJbTvg1pY=;
	b=KJ9H8AEZSOar1woE+XUTutudE4fgG6nD6rQQgZVCHrNPyCdoVtDp/Zoy3hH66OUQFMLH
	 P/ETlYOB2sGKgN2nce0SDAKXG07kcuWo+O3csKkZFCM9csOM26TGVcQ2t8nlLsS/B5Tae
	 9I/BRlsuYf7UQ3g5zQbhKVX8rN2ShUpdlVof2V9iegpjCCnTUahOTA31J6XpJ7rIKQbAn
	 hxJMLh8j3RtQkrr2W9Ks6px6vAfRRUQsYXb9MYHQvYc8bv6dUISAHkLwj0iA9PB06sWyt
	 HsB0x5NGcn/ZLnwHVo/2KvUwLzGsGxERJ5txlVjXPzLYyvkt8dd2mtjESV7Rm53LudQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=awj+6w00;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794457478;
	bh=zhqY3AvClzTF/3fBqtg4yRX6p4Q/NNp6yltJbTvg1pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VnVu7zelDfSFYCdcIXCUyQb0gQr6Fwb2Vn7jUaXhsHvxGhvI1BoxWggynG3tPHG6N
	 v1+kO4qjGyTbKcW0J42WGhI70PtdrdYPPPE95rXVFofquTaz4dO3WvU9CgVyQ479FR
	 k2XHicugEunJC4C6y0JWXqlUF6OuJz7WwW9GB9wAJ/z0K9PX9eVk3+mpMRqCpbLgW1
	 tljgwpdyPGpp+0seod+EkAktMX416JOFS/Zm5OEtfTzBAmSklC3uARVuyBIDxxoPxQ
	 8ckKnlL/yO3uIYe+X/IaK73ECAoKcA2v6Sb12MJmU2fhPlihduJ3dsXeSwH3Zy2iqP
	 nhar4HalXIUkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B790409A0;
	Thu, 12 Nov 2026 04:24:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BF7A6EC3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A59434057C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qk-Jw1tqBLMM for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 23:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8A8D140573
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ekovsky@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=awj+6w00
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A8D140573
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794438752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zhqY3AvClzTF/3fBqtg4yRX6p4Q/NNp6yltJbTvg1pY=;
 b=awj+6w00ziR0RE6pCrvmgOueQcd9S/6X8krvPi3SvkFXlgARJug6IT0y5O20tUcPjy4kQX
 zqacgGgk+YcCgNiKpzJYkFOzJ9azqYYSatail3fyJ6QNA9n6ewHqnPXtzRwQUjdUzA4pNu
 KofP3zGq6w13eHZo0/h4SL9zlQLF/58=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-ZGAp9hgNOTGFiqCQMJ86nw-1; Wed, 11 Nov 2026 18:12:30 -0500
X-MC-Unique: ZGAp9hgNOTGFiqCQMJ86nw-1
X-Mimecast-MFC-AGG-ID: ZGAp9hgNOTGFiqCQMJ86nw_1794438750
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5337b591609so58601421cf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794438750; x=1795043550;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zhqY3AvClzTF/3fBqtg4yRX6p4Q/NNp6yltJbTvg1pY=;
 b=zORkiBprJecryFnKfd0xGCq+3aqH4BIjn9H98JnQ19gRVMUplkYfDsD9++40TyEJsS
 jt3/sFU4e1hIYFJGgzsiDG4G60ro5qkAMnOk9+WIQXplv1XKgvJ/J803oCTwH2c2AfeO
 D5JCZcp+0ZdHDyHxbGYeR0AgIi9vfFmICdOagpT8sNmHgxAjtR4Rd/ikHzsUGxptkHxu
 PqL3nO+Ix/qlMA75YUgASmPfk6xJM7888xBT2MFfBCHOeQr29I2ZpI44ZztzKSYsfdzS
 AVWenYTuXkg6CsvJ8Bxho5/jxLCZM23zYCNuw7K5MGQQDkwdhAfyY91Me7hN3DuDMHKu
 Ru2g==
X-Forwarded-Encrypted: i=1;
 AL+hErEA6505pfTGltblrA/EagSGy48sYRx2B3Njg79LX7tqPYSjB+GyoiL9I6uHXsOd96yX4DvULcA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9IPEKOht/siP7vxwFEkfI4DOibwhad56Ki8XEssgNKONPhJrkr
 JbI/FLP2Wr0cLmFoA0giVQjFqeakyD/Tcvh2XaxJ8Rr98tcZjQN6njFd1HawmR4ZF3xVOwLWBBO
 ibWMHLHarVCoU3UOoIeQ3jTKo26htBLJuU+d1toiLOHhlI9Kn/zr96CxbSzopES5BhmPbAA==
X-Gm-Gg: AYBFou0suYGC+Y2LBQ65mwapYNyZB8qVm3XIAIAs7KeHxZ3eGgoiSNCDzVob0//Qyvo
 L4X6zraBxor5e0tiqOSqaox/FvKkjjPJAJzp5Gto0Pk6EfDckjf6olBeAVBMLan37846V6Hrhki
 VlomkI9hA/PH1A++ISqeEWJTqaVaXr8pnK0hv9okjA60txTLvH3Q7Epr/MsP6dxYjHs9LSjShyI
 8iETjEL4Ng2SEJbVxCgAkGtH6+ci6o4vV+xZMiqkok0tlyISqT63GMlRkRrvTCd/n4jFqbUO4VR
 eOmuRB8wx+TFod5f50SpudPduRjzhbS7omYrg1zohoACpj7JkkmVL3UYNe6Wn9HsA8RBELj5uTJ
 k6VFMpgYDoCBsc3xG12VKVOK8KHjsUkd8uLqNN54MGjA=
X-Received: by 2002:a05:622a:5a17:b0:536:52e6:fda9 with SMTP id
 d75a77b69052e-556c06e353cmr64097201cf.32.1794438749781; 
 Wed, 11 Nov 2026 15:12:29 -0800 (PST)
X-Received: by 2002:a05:622a:5a17:b0:536:52e6:fda9 with SMTP id
 d75a77b69052e-556c06e353cmr64096511cf.32.1794438749074; 
 Wed, 11 Nov 2026 15:12:29 -0800 (PST)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f00f6eb88sm37459776d6.39.2026.11.11.15.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 15:12:28 -0800 (PST)
Date: Wed, 11 Nov 2026 16:12:27 -0700
From: Eddie Kovsky <ekovsky@redhat.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 u-boot@lists.u-boot-project.org, Bastian <bst@pengutronix.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: Re: [PATCH v5 0/3] Add support for OpenSSL Provider API
Message-ID: <avT2W0RNmRp9tSat@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <f7b2f1f2-e8c6-47c1-8e47-795f6ade7618@cherry.de>
 <auy1K4oe9E2Fr9xu@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
 <83adafeb-674b-4e2f-96c9-b8eb7694dc0a@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <83adafeb-674b-4e2f-96c9-b8eb7694dc0a@cherry.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: --AANE7UObMnqaV-se5gQh3ISFwvB52HUYEYK9NUVfA_1794438750
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 04:24:36 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26, Quentin Schulz wrote:
> Hi Eddie,
> 
> On 11/5/26 5:56 PM, Eddie Kovsky wrote:
> > On 10/30/26, Quentin Schulz wrote:
> > > Hi Eddie,
> > > 
> > > On 10/29/26 9:13 PM, Eddie Kovsky wrote:
> > > > The Engine API has been deprecated since the release of OpenSSL 3.0. End
> > > > users have been advised to migrate to the new Provider interface.
> > > > Several distributions have already removed support for engines, which is
> > > > preventing U-Boot from being compiled in those environments.
> > > > 
> > > > This series adds support for the OpenSSL Provider API while continuing
> > > > to support the existing Engine API on distros shipping older releases of
> > > > OpenSSL. Build dependencies for local development and CI are also
> > > > updated, while the final patch adds support for using hardware tokens
> > > > with the Provider API.
> > > > 
> > > > The changes have been tested with the FIT signature verification vboot
> > > > tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1. All 37
> > > > tests pass with both the legacy Engine library installed and with the
> > > > Provider API.
> > > > 
> > > 
> > > I'm NACKing this series quickly because we are having pressure from multiple
> > > projects and Tom would like to see this fixed ASAP, and this version here
> > > should not be merged. From a cursory look a lot of feedback was ignored,
> > > possibly because I did too many rounds of reviews and it got difficult to
> > > follow. I'll therefore spend time next week to collect the reviews I made on
> > > v4 and that sill apply and post them condensed on this thread.
> > > 
> > > Please, we just need to fix the build issue for 2027.01. We don't need
> > > providers in 2027.01, just the ability to build on OpenSSL 4 and on distros
> > > with OpenSSL3 with engines disabled, without breaking OpenSSL engine support
> > > for other cases. If you get a patch to fix this, please send it whenever you
> > > can, I'll still collect the reviews from v4 and post it here. If you're not
> > > interested in doing that, lemme know and I'll take over this part and you
> > > can always test the patch(es) if you want to.
> > > 
> > > Cheers,
> > > Quentin
> > > 
> > 
> > Hi Quentin
> > 
> > I designed this change from the very beginning to maintain the existing
> > code base and preserve backward compatibility for users of older OpenSSL
> > releases who are still using the Engine API. We cannot add support for
> > OpenSSL 3 or later without moving to the Provider API because of the way
> > the OpenSSL project has changed their interface.
> > 
> 
> That's not true, as already said in v4[1]. We currently support OpenSSL 3
> and engines, and we actually test this in CI. You can test locally by
> running the following commands from your U-Boot git repo:
> 
> podman run -it --rm --security-opt label=disable
> --userns=keep-id:uid=1001,gid=1001 -w $PWD -v $PWD:$PWD
> docker.io/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
> python3 -m venv /tmp/venv;
> . /tmp/venv/bin/activate;
> pip install -r test/py/requirements.txt -r tools/binman/requirements.txt -r
> tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.txt -r
> scripts/dtc/pylibfdt/requirements.txt;
> export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only;
> export PYTHONPATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt";
> export PATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}";
> ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w --board
> tools-only;
> export TOOLPATH="--toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools --toolpath
> /opt/coreboot";
> ./tools/binman/binman ${TOOLPATH} tool -f missing;
> for test in testFitSignEngineSimple testFitSignPKCS11Simple
> testFitSignPKCS11Object; do ./tools/binman/binman ${TOOLPATH} test $test;
> done
> 
> You'll see all engine tests pass.
> 

I assume you are referring to my second sentence "We cannot add support for
OpenSSL 3 or later without moving to the Provider API ..." I can see how
that wording could be confusing.

OpenSSL 3 deprecated the Engine API but did not remove it. The Engine
code is still present but not callable in v3 because the header files
were removed to help prepare users to migrate to the new Provider API.
And OpenSSL 4, which is gaining more adoption, removes the Engine API
code entirely and only makes the Provider interface available.

Some distros, like Fedora, added an optional package to put the header
files back alongside OpenSSL 3 so that projects (like U-Boot) which
hadn't migrated to the new API would still build using Engines. I don't
know what the base image of your container is or what release of OpenSSL
it's using, but it's likely doing something similar to keep the symbols
available. But as it stands right now, U-Boot will not compile in
any environment that does not provide a bridge back to the Engine API.

I've found that the fastest test of which API is available in a
particular environment is to (optionally) sprinkle some printfs
throughout the lib/rsa/rsa-sign.c and then build the tools target. The build
will succeed if the headers are available, but quickly fail otherwise:

    ❯ make tools
    --->8
    In file included from tools/generated/lib/rsa/rsa-sign.c:1:
    ./tools/../lib/rsa/rsa-sign.c: In function ‘rsa_engine_get_pub_key’:
    ./tools/../lib/rsa/rsa-sign.c:115:9: warning: ‘ENGINE_get_id’ is deprecated: ENGINE_get_id API symbol is removed. Define OPENSSL_ENGINE_STUBS to mask linker errors. [-Wdeprecated-declarations]
    115 |         engine_id = ENGINE_get_id(engine);
        |         ^~~~~~~~~

    --->8
    /usr/bin/ld.bfd: tools/generated/lib/rsa/rsa-sign.o: in function `rsa_engine_init.constprop.0':
    rsa-sign.c:(.text+0x15): undefined reference to `ENGINE_load_builtin_engines'

To fix this build problem in an environment where the Engine API is not
available (even if OpenSSL 3 is) we need to call the Provider API to
replace the equivalent functionality. There is not another fix to the
build failure unless you want to make a declaration that U-Boot is
pinned to the Engine API as a build dependency.

I also want to emphasize that I have been careful to keep the existing
Engine code as it is. The new code is there to support the Provider
path. We collected at least one Tested-By trailer from a LibreSSL user
early in review, and I recently found a way to test for regressions with
OpenSSL 1.


> Additionally, from my branch at https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commits/openssl-providers,
> I have tests for both OpenSSL engines and providers *at the same time*.
> Here[2] is the log where you can see none of the OpenSSL engine tests are
> skipped and only the PKCS11 provider tests are skipped. They are skipped
> because we don't have the proper package installed inside the container but
> I tested this locally months ago and they pass if the package is installed.
> If either the engines or providers weren't supported, you would get a skip
> with a given reason, see [3][4]. [5] shows that you can build both engine
> and provider support in lib/rsa/rsa-sign.c.
> 
> If what you said was true, we would have had a build issue when every distro
> moved to OpenSSL 3 when it was first released 5 years ago, which didn't
> happen.
> 

That's correct, because as stated above OpenSSL 3 only deprecated the
Engine API without removing it, and some distributions still made the
headers available.

My second patch, along with the CI work Tom did earlier this year,
addresses the missing package in the CI container.

> [1] https://lore.kernel.org/u-boot/8d7ff3b6-abb9-4441-8491-99c538ea5f2d@cherry.de/
> [2] https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/jobs/79119/raw
> [3] https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/blob/openssl-providers/tools/binman/ftest.py#L8339
> [4] https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/blob/openssl-providers/tools/binman/ftest.py#L8719
> [5] https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/blob/openssl-providers/lib/rsa/rsa-sign.c#L22-L33
> 
> > Both I and other reviewers have tested the proposed changes on different
> > distributions using different OpenSSL releases. The build failure is
> > resolved on OpenSSL >= 3, while building with the Engine API still works
> > as expected. (The only obstacle we found was that signing with a
> 
> Run the list of commands above with your patch series applied and you'll see
> it doesn't work.
> 

What commands? You said the podman local test runner does succeed. If
you have an example of a specific failure please include the complete
output along with the commands and environment that reproduced it.

> > hardware token key using Providers didn't work, partly because the
> > existing code doesn't make the pkcs11 uri parsing available on all
> > paths. But Johannes already proposed a solution that resolves that
> > issue.)
> > 
> 
> I'll discuss the provider part later on, I would like us to focus on the
> OpenSSL engine build failure for distros where OpenSSL doesn't support it
> anymore (Fedora 44 without the ability to compile code using engines anymore
> unless openssl-devel-engine is installed, and every distro with OpenSSL 4)
> while still keeping OpenSSL engine support working when it is possible to
> support it (all other cases, including Fedora 44 with openssl-devel-engine
> installed).
> 

See my previous explanation.

> > What are your specific concerns about the code in this version of the
> > patch series?
> > 
> 
> See review on patch 1 (posted a few minutes after you sent this mail here,
> unfortunate timing). But essentially, this breaks OpenSSL engine support on
> OpenSSL 3, which is something that is supported by OpenSSL and which we want
> to keep supporting.
> 

As mentioned in my commit messages and earlier in my reply, I have been
careful to preserve backward compatibility for users who may still be
building U-Boot with the existing Engine code path. Your other email
states my patch "will break" distros like Debian and Arch. I've been
testing on Debian stable and not seen any problems. How did you
determine that Engine support is broken?


Eddie


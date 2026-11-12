Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E31606A89D
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kUtsAlsC;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XFzxthOg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C397380E33;
	Thu, 12 Nov 2026 18:32:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nAAtf9T2mThQ; Thu, 12 Nov 2026 18:32:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 174D780DB1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794508349;
	b=P/PEZ9BXfwOUWDgboOiICV1ONi3Re6eCJIynThJLXaaD3sJ2mlaW3+NSkhvku+wAXqhY
	 5XocO5zK+zVq3Cy3YqQo/PQ5Pg1BNtGvRAX8j1d+O6apyOJgkJnorKoWgkE62fY2BALIn
	 PbTNBofpjXtt7V/Vk4uhN8lspcA/s8QEl6nYzH4L5u8jZZRlRxDDEQaLzD2vB/ZvzPLnG
	 ia8QHQxilpcecxba/1DGYWzLO5ou1KGnOQaPWBR1lNuBDDQwYmB9ClBs67anRACq9effL
	 c097MsLDDAWQDRMHncKDxdoTm5cQ/8sj1qP/PujDFt7+Zxo5Yg4S4R+FMpuhyKIkm7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794508349;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LxvFbK8ngOEuJ52oRALyCVzFzs37GNUv0rGHYClOYJE=;
	b=sWM1ptdVpiQsfCgpuSF6JFgfh7BM0v4WuwG0GivhJ8kZ9odQ88LeQMLBKES61t2nuxit
	 mPQ+W2oSwF3MhnrHWHVmQhRurqzTIOuCOLcZQ0VIjl3H381P/twOFLsgX9e898wZqGJIz
	 U5F4yvr1XtXBRb5+fA+4BbEhguvjP4c2uHsOX3LpV4vUxt0ypLRT3PO4CKxusYneXPnM8
	 fZdVIdoP5VNOGe4kZjP1vhEkZYpYXEhsFAABv2yho/yQhaWvQja+ddbBhG5yUu9Oxe9bA
	 NFbEZteS9ahwLI97gd/Q76zZVVvyXhjME8clobIs2/5iia1Y0B251qJoN6/RjHLDHTg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794508349;
	bh=LxvFbK8ngOEuJ52oRALyCVzFzs37GNUv0rGHYClOYJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kUtsAlsCi+j2Wcb0RP5WAuwqDlsHtxiuGTVqe8wryBGZCoBwbl2FrOm73nEYFg3Y8
	 vLVPMfOXIFq/8OIoSH80EiiVPKN9K0mctrKeaGIZ1nFFmjLScBxgir8caLnUGFX0BH
	 dyfh6RtfBPxy1/ZJrwD1KtlLL62hwYyqVcLyOohHN94CPftMc/hgmq4W6n3JXq9Ag0
	 l+OhRlfEJ8RRcNmMDGsIZxQtx40HyTKnHVSkaZXJyJMbEQNybbdvNQ34Ebk36S2rZy
	 AcCmLWOuRhoRSIn477xbrZVAelaCU41suFsO8AHu7i5Zl+GrCH0BtBugeiBqR+VL+3
	 b6VRHZVW62J7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 174D780DB1;
	Thu, 12 Nov 2026 18:32:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D312F1370
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C44C8608E4
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPLfMkIPj0tG for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 18:00:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D94B0607F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ekovsky@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=XFzxthOg
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id D94B0607F7
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794506419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LxvFbK8ngOEuJ52oRALyCVzFzs37GNUv0rGHYClOYJE=;
 b=XFzxthOg39SGrDUWkkv+7OPW6vVhndvVs4qHaba+ODmUU5iXdiJrqfJlKcpMS80Nuoddb5
 4qWdQLkVaRJQ5EZ62ZQ7Jc+F7Yfy+eIWvHwkxUfR+a0EFylt6zVv/wc6+jLEOo27kyrz7B
 kOry0uhcXbUyFwKen5BcVxlyFYveaQ0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-rZiM3gPfMomLD6Q3oEYjng-1; Thu, 12 Nov 2026 13:00:17 -0500
X-MC-Unique: rZiM3gPfMomLD6Q3oEYjng-1
X-Mimecast-MFC-AGG-ID: rZiM3gPfMomLD6Q3oEYjng_1794506417
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so187485a.2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 10:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506417; x=1795111217;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LxvFbK8ngOEuJ52oRALyCVzFzs37GNUv0rGHYClOYJE=;
 b=KvTQAPEe2hcTCBE76tSldrJwIPAGEUa0pAWJ0nGaT/MCDjzWwGQwzjlAuQMFFun9tH
 T/RAirHYMyp4MWpDf8fMDYSs6Q/SISWOZU/udIJ+iQaNuEFpfgVZLCjWQAWzrBLCcgXt
 l51CB/SVMDLZPMzdJpWHckcK/CrbjO85jsRz3K1s67bxLUcVTpS5KSpNOTmDNBLi97BI
 JsImCWqZfmrj9PvxKAN54sMjooaWUtRVWaa+dGYNh/0d/6Esojv7OPrGCLo3wj1cUcLm
 kzPSoO0BoMEjTfrTi+wuPVxuHmS4JRHjY9rabsPLuX3TCJXzVThiYHQA8yd4Q5Z+Wl8H
 NVFA==
X-Forwarded-Encrypted: i=1;
 AL+hErEjpSRqSYVEFBZqG4iA4NoETQipQTjY47PN+QvD6PPvnMr2irUyF5yIBwkACa+ycj/Idlyfpsg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8tBuTaib068sufd1xpIIKJQverCcBWY0BpC7zl6y7z5x9zR2+z
 MOY26XWBIAngGMTdetUk8rNf48W6Eig3iT3okxzqWBsxx/Xt4i938Amo+x6E20h8nwbcFPYOj5z
 N2pXzqlm+2J1zIzu5fXsgWDh19EVeHnSh0dVOGYXQIlAAc7yGMhN0yWxxtwvRGtYLRiWf0A==
X-Gm-Gg: AYBFou3Jhef9EQJpErxR/v4I2CB1vwXN6jLW1ro39llyVCWeCZMRKFzfnJ8bnyJAeGQ
 11kDP1Bn44ULC2AXa0kItDCJbozJv0gXR1ifviZfp4UP8Q+kyea98fWzsQ2mKoQ7U/Q3gqekJ1/
 C3I4jsr7wXtOa25/PAzyfBSMaNUwveNLuKIQ/Gy9HmevJiENrUfS1w/JKxAcW937j2YOvkMQ56K
 A5r0/RzrBoKgmKeMbU06yalF1gsZ4BSiEW66S5qhW+FoTD84n/RukMRLvaMVAxczheu7Bd90owl
 WIVZNhrehJO513hJpwnkAcaoTon0SOUknxOQY0low6X5RF1hsrpQs5rMNxWomlvvKVvFQy504Sz
 ffGZZbvJ+6fwBHYT2cbA7tMW8DIsoLGZRD6ex7/fzpxE=
X-Received: by 2002:a05:620a:26aa:b0:93e:6394:5e37 with SMTP id
 af79cd13be357-9494ba7e01amr30475285a.14.1794506416534; 
 Thu, 12 Nov 2026 10:00:16 -0800 (PST)
X-Received: by 2002:a05:620a:26aa:b0:93e:6394:5e37 with SMTP id
 af79cd13be357-9494ba7e01amr30463285a.14.1794506415605; 
 Thu, 12 Nov 2026 10:00:15 -0800 (PST)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e7a7ae0sm780722585a.25.2026.11.12.10.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:00:14 -0800 (PST)
Date: Thu, 12 Nov 2026 11:00:13 -0700
From: Eddie Kovsky <ekovsky@redhat.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
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
Message-ID: <avX-rYhyj2UCh4Mr@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <f7b2f1f2-e8c6-47c1-8e47-795f6ade7618@cherry.de>
 <auy1K4oe9E2Fr9xu@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
 <83adafeb-674b-4e2f-96c9-b8eb7694dc0a@cherry.de>
 <avT2W0RNmRp9tSat@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
 <CALeDE9NtK9F5zebiL6vXLHm5V-iBw+kw5Ld0JuzAb8EHPQauDA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALeDE9NtK9F5zebiL6vXLHm5V-iBw+kw5Ld0JuzAb8EHPQauDA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iThBMu15yALuz2ggOyVe9sJUHPE7w1Eiw1ulAn4jZvw_1794506417
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 12 Nov 2026 18:32:25 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26, Peter Robinson wrote:
> On Thu, 12 Nov 2026 at 04:24, Eddie Kovsky <ekovsky@redhat.com> wrote:
> 
> > On 11/11/26, Quentin Schulz wrote:
> > > Hi Eddie,
> > >
> > > On 11/5/26 5:56 PM, Eddie Kovsky wrote:
> > > > On 10/30/26, Quentin Schulz wrote:
> > > > > Hi Eddie,
> > > > >
> > > > > On 10/29/26 9:13 PM, Eddie Kovsky wrote:
> > > > > > The Engine API has been deprecated since the release of OpenSSL
> > 3.0. End
> > > > > > users have been advised to migrate to the new Provider interface.
> > > > > > Several distributions have already removed support for engines,
> > which is
> > > > > > preventing U-Boot from being compiled in those environments.
> > > > > >
> > > > > > This series adds support for the OpenSSL Provider API while
> > continuing
> > > > > > to support the existing Engine API on distros shipping older
> > releases of
> > > > > > OpenSSL. Build dependencies for local development and CI are also
> > > > > > updated, while the final patch adds support for using hardware
> > tokens
> > > > > > with the Provider API.
> > > > > >
> > > > > > The changes have been tested with the FIT signature verification
> > vboot
> > > > > > tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1. All
> > 37
> > > > > > tests pass with both the legacy Engine library installed and with
> > the
> > > > > > Provider API.
> > > > > >
> > > > >
> > > > > I'm NACKing this series quickly because we are having pressure from
> > multiple
> > > > > projects and Tom would like to see this fixed ASAP, and this version
> > here
> > > > > should not be merged. From a cursory look a lot of feedback was
> > ignored,
> > > > > possibly because I did too many rounds of reviews and it got
> > difficult to
> > > > > follow. I'll therefore spend time next week to collect the reviews I
> > made on
> > > > > v4 and that sill apply and post them condensed on this thread.
> > > > >
> > > > > Please, we just need to fix the build issue for 2027.01. We don't
> > need
> > > > > providers in 2027.01, just the ability to build on OpenSSL 4 and on
> > distros
> > > > > with OpenSSL3 with engines disabled, without breaking OpenSSL engine
> > support
> > > > > for other cases. If you get a patch to fix this, please send it
> > whenever you
> > > > > can, I'll still collect the reviews from v4 and post it here. If
> > you're not
> > > > > interested in doing that, lemme know and I'll take over this part
> > and you
> > > > > can always test the patch(es) if you want to.
> > > > >
> > > > > Cheers,
> > > > > Quentin
> > > > >
> > > >
> > > > Hi Quentin
> > > >
> > > > I designed this change from the very beginning to maintain the existing
> > > > code base and preserve backward compatibility for users of older
> > OpenSSL
> > > > releases who are still using the Engine API. We cannot add support for
> > > > OpenSSL 3 or later without moving to the Provider API because of the
> > way
> > > > the OpenSSL project has changed their interface.
> > > >
> > >
> > > That's not true, as already said in v4[1]. We currently support OpenSSL 3
> > > and engines, and we actually test this in CI. You can test locally by
> > > running the following commands from your U-Boot git repo:
> > >
> > > podman run -it --rm --security-opt label=disable
> > > --userns=keep-id:uid=1001,gid=1001 -w $PWD -v $PWD:$PWD
> > > docker.io/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
> > > python3 -m venv /tmp/venv;
> > > . /tmp/venv/bin/activate;
> > > pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
> > -r
> > > tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.txt -r
> > > scripts/dtc/pylibfdt/requirements.txt;
> > > export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only;
> > > export PYTHONPATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt";
> > > export PATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}";
> > > ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w --board
> > > tools-only;
> > > export TOOLPATH="--toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools --toolpath
> > > /opt/coreboot";
> > > ./tools/binman/binman ${TOOLPATH} tool -f missing;
> > > for test in testFitSignEngineSimple testFitSignPKCS11Simple
> > > testFitSignPKCS11Object; do ./tools/binman/binman ${TOOLPATH} test $test;
> > > done
> > >
> > > You'll see all engine tests pass.
> > >
> >
> > I assume you are referring to my second sentence "We cannot add support for
> > OpenSSL 3 or later without moving to the Provider API ..." I can see how
> > that wording could be confusing.
> >
> > OpenSSL 3 deprecated the Engine API but did not remove it. The Engine
> > code is still present but not callable in v3 because the header files
> > were removed to help prepare users to migrate to the new Provider API.
> >
> 
> Are you sure that's not just what Red Hat did as part of migrating RHEL
> customers?
> 
> 

Yes, sorry. I'm losing track of how each distro has managed the API
transition. OpenSSL only turned deprecated symbols into compiler
warnings, which are easy to ignore. Fedora went a step further by
packaging the Engine symbols separately.

https://docs.openssl.org/master/man7/ossl-guide-migration/#upgrading-from-openssl-111


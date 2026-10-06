Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2737ACA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 14:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E722405D8;
	Tue,  6 Oct 2026 14:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aQVFMLQcw7Lu; Tue,  6 Oct 2026 14:33:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A304640500
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297193;
	b=s4wx8147S8Tp0WeCRes+AvHRfl9D5mUsep62yPn2FIn1buNLZu0urNT6nc+frfO9Tetk
	 YJZZqJ8u5bIwq2JY7ST8AskO2uFEVJACEybThn6bkIodewc+SCaOyheLhwoRHpTGZ1i/J
	 cTmjJAONjOcM2UJx9rOnADpVUzkoOnwMy2DxcCVi7CV7rKK/GT77X8DcWpbz+9/lowoeA
	 iCydol+q7vAyNhDWDQNAaVutAfiV4YBLPhJs95AkA9aTsU+3+419IH7nBNswUDYkkv1b7
	 aPho/Kl8Axg6a4RKI51k++LkNtuimxgJYwXYRhwfaongMFHpt6c5XXKNtv8GPS8YCfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ou64BiljQvLoM9a0M7+Puf8CFlhKMrxhHcXKxcQxxJ4=;
	b=RpYV/Sc1y8cxbXdlzuEfP93uPMeGlQ9bCf2QRbNuQ3+7Jh3HXQ0AR0TBKNYhHeg5QfSA
	 UogPKFL5kuePlPGZpe7F4ZB5Le2Qgl6k3aJYEVsnSDfp/1GkpcH+xEfWTWc/wqCR7Ljd6
	 +eNZNDPR6z//5iLNmjH7qCz7+haADIcmiwVC2MskGJKH91EApMKLRQxyqJ0l+s0xIUARO
	 TzQZyX8rwZK1nrIyaD5+v3Ytiwvia/oFG5evBkgROxa/6Fa5faGOb1SyI5z/RPmjkq/Nl
	 vNaotrtMxGfYhfs68S6gs57jS4zejFUoF92i2k5RkfMC/rg5dwy1+tvzBBeeN5aKiWg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791297193;
	bh=ou64BiljQvLoM9a0M7+Puf8CFlhKMrxhHcXKxcQxxJ4=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YZlKW3LKQK+gB0cwKRxZQahHRC/jnUhk47ZL4oVGXlk8l2a61GivNLZ7aQKWLw/YJ
	 epcVJdoMiSl2GNICV3xr7JKWlJ1JR0//BX/sAcWGQxPFor+lFEk7e5YNKv+NPCvvar
	 M+WckglyjBRFP86TMH700NW7jaR9210e6WWoTo+C/L1Ox0Aw9YoLxJA168//WM4LMa
	 OzbcZxiqw44gNzaKcUcZKoadMQdrnLKldh4mx1EMxPFu4BRrnv77qkbvy9F6LTxD2t
	 Z9U8fEnfaD9ofC76fgnEckQN/tJDgc+Lqp/UzXI1BKZkHr54mIowME4BydsYf1plcy
	 8457c06ybk74g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A304640500;
	Tue,  6 Oct 2026 14:33:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E126E34E
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 13:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D323D80847
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 13:23:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YiXdBToEBiCr for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 13:23:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 02C5F8083C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791293029;
 b=XVcFmmhHJXc7BqRt3k9dTmcSAXHnrjEGw9T4EWz+wDzt8Q4qgSpKiknrI3nlgBzMlPiD
 rVs4u+/H/NzWSRGBS5IscrbbAxKhKh3dhDkl1+E9qirDAhR6aEw+BRrpBNjMxuLdrud3O
 82raXfC6VsEDXL8UZ3fzjm0qclxDxhcrVCwMGxumQ+9kqgv0IGIoUhbVlvZqKwe6vJ5z6
 j12wCTG/jz4KhgLqcp40DroAI1aNj4qfB4FHj+23Wdrr3H30/nWtpZvu9Ke9ao7hezRoW
 UnhnHEl9qOuqPxMejo6CIfo5lgfppDh2+xyHOIL0Efyb/S/1U9ovMlPPdpBnwnhc5/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791293029;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=ou64BiljQvLoM9a0M7+Puf8CFlhKMrxhHcXKxcQxxJ4=;
 b=VVYJw8YOAhdRi438hm4yA7LPAmtMUVofM+AfFGxMXeRG0LThNsS5kokPksTueCjAlhEH
 Ivm4uR2z4e6zTz6q4/ILxm/kgDdyb+ztgDnvGWUQMdt8JjGDoDLCkCEDUGlUbPVhIi5IG
 xD0etVXHuXKK2Zbqi+HH7u5+oO5bgL4NPb0ZNuo0o/+0webcTGJCJwzhs6ZGFBOl53Fgz
 Zk+laAuddDInxw7b4DsJc9Mq0rBBRxjFIKAzEveOwk6qTcjZAPMrTqfwbDeMFGpDrkkax
 dprRNhic1XJFxBtEq0BslNxidj4Bg8C7FCt3iP6fW7IbCZp1A5NB3H/DByZl7U+tohg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b="v+3A/+n4"; 
 arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=petr.hodina@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=v+3A/+n4
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02C5F8083C
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 13:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791293019; x=1791552219;
 bh=ou64BiljQvLoM9a0M7+Puf8CFlhKMrxhHcXKxcQxxJ4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=v+3A/+n4vr6O62vBWGBaOE8W733nxseZLFc3Y++Y2Uc/qlMKUUu7uvj95dbydfLDu
 D/QsEScM9tkEH7XMk347R9WgBjLtvnR5EHgZB0rkkCd7wgO9FfsQL+OuHk4DCxhzL4
 4tO7i92wDHT4iijbDwgSCEHpR9brwAxUQ+E8sqfr6Sg54nDttsmNV21+FgUeafjQmV
 7W5xV4hDobLbYNhlgoQfa2wfbZ2QPKajOILMUu4/0ng2xprT66/UDYODY62S8Xwt4w
 gO2OSOyDsbk3K/fOwXfiHmKbhdEaSIDh5SrW0nPhDsFGLIHV7MQBHnYFbH9Hal3ShS
 iLWniPPXcNjNg==
Date: Tue, 06 Oct 2026 13:23:30 +0000
To: Neil Armstrong <neil.armstrong@linaro.org>
From: phodina <petr.hodina@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 David Heidelberg <david@ixit.cz>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Julien Stephan <jstephan@baylibre.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>,
 Michal Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>,
 David Lechner <dlechner@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Janne Grunau <j@jannau.net>,
 Julien Masson <jmasson@baylibre.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Petr Pavlata <petr@acrux.cz>
Subject: Re: [PATCH u-boot 2/8] ufs: add device-quirk infrastructure
Message-ID: <7rKXOZ-hfdoWG6W8EV0KZMZEQoLnN88eTHGkjZyZp6NZVxWMVMNEzgxIpFVVt3Bhz3udjTeXmGWrrxbUqMlBjUdqrErfKptrs3PmeWl7RAA=@protonmail.com>
In-Reply-To: <44f92663-e15c-422e-ab48-eec68904ad49@linaro.org>
References: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
 <20261004-b4-ufs-sony-v1-2-54e71c95ba62@protonmail.com>
 <44f92663-e15c-422e-ab48-eec68904ad49@linaro.org>
Feedback-ID: 23468634:user:proton
X-Pm-Message-ID: ce2f7fd3b25a405b57c60d01790850b5e0744690
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 06 Oct 2026 14:31:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


On Monday, October 5th, 2026 at 11:40 AM, Neil Armstrong <neil.armstrong@li=
naro.org> wrote:

> Hi,
>=20
> On 10/4/26 21:22, Petr Hodina via B4 Relay wrote:
> > From: Petr Hodina <petr.hodina@protonmail.com>
> >
> > Infrastructure (ufs_quirks.h):
> >   - struct ufs_dev_quirk plus UFS_FIX()/UFS_FIX_REVISION() helpers.
> >   - ufshcd_fixup_dev_quirks() applies the table (and sets NO_PURGE for
> >     devices older than UFS_PURGE_SPEC_VER) from ufs_start(), before pow=
er
> >     mode negotiation so link quirks take effect.
> >   - hba gains a dev_quirks field, distinct from the host controller
> >     quirks (hba->quirks).
>=20
> In patch 7 you set the quirk for the Sony Yoshino/Tama platforms, but
> I'm not sure we need to add the quirk for those UFSs on other platforms.
>=20
> Is this really needed for all platforms ?


This is more defensive approach to enable it for more platforms.

The reason is the device is a production unit with secure boot enabled.
Therefore I'm unable to provision again the device non-volatile storage.

Also there are no EDL loaders available unlike on some other platforms
so restoring the device is currently impossible.

Even with the loader just physically desoldering the UFS BGA chip, then
replacing it with a new programmed one with the dumped data and soldering
it to the board it would probably not be possible to boot as the RPMB block
would be missing the Authentication key only the manufacturer posses.

I'd assume this issue might be already fixed on newer platforms.
Would be great to compile a list of the platforms that definitely
need this fix.

Kind regards
Petr

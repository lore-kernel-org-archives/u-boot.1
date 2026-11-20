Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5060A2629
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M2wo4BSS;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=DL+HtZT2;
	dkim=pass (1024-bit key, unprotected) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=fTtenRxh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E743540838;
	Fri, 20 Nov 2026 18:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iV_fAedFGdQG; Fri, 20 Nov 2026 18:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A6BEF4064C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795200877;
	b=kHc6KLLxSsgTczL62E5JuOMfKveSRFEz0WOIRrygGdgcdaYkOK8BE2PUjzpYwCLneIeX
	 aEIOxRQaM4Bwvtqb1LfalT7zQLkmasVWeY3BcRulRwg+baxYRB5aG1rpC2ycXllTsGfuu
	 FS/1BwL3Dv/phBn4ga5jwzCLOA+Ox3+Z6ObcJxxHO4GA5WijElRXuS6+PWhLBoSBEBK+2
	 UuhUdi15ak4KvGugK7hF0Y/GPtt9ToaqDA+BzuBET8W9hp/se0mAfwgMr4popBrBb2rXe
	 QXVcCcqY3Af469Qxna/6DyEVUw1tarXX5YCBylWJn2Ba2E8HibuPDlF2mq/duYgMyuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795200877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:CFBL-Address:
	 X-Forward-Email-ID:X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CSyXkpmQpJrSqWHuGSZHoSrr0SU0hwP0p8VHtIBUO78=;
	b=C7/Bp/4YU2v66tlNTOMJHpp1prja7kGq/XZv03U5aDjiyRzAxv4h/vWyE8is9MFJ5wyc
	 Xk3Alen8pKEpbeXzTC1/fI/7ZdvX1eD6xim7u95cNETjQpB1OdghHuR/DIzJ6MYe4QLyS
	 J2sQ60O63VSZ37/wJCK7TuYgIONxyJ53cmjoGAWZmpUmTJ58Y7MWTo8QpGCp7JK0PpgSC
	 hJ3ImlhFc6K54VmnNUS3QPnuYtOUD2i+338G3rV1l3aa3eNt4zy0quYEx44QIwLEc6PAG
	 Mgb0WyXrMAqs9Rk5VtWGGGcqGUcp02YZekruc/2a62nE5Iukac3ZYczF0uWB6NGqSJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795200877;
	bh=CSyXkpmQpJrSqWHuGSZHoSrr0SU0hwP0p8VHtIBUO78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M2wo4BSSA0efkdmYeVkqUGz4E7oYWLplOVI8gx/yxHI1UbgF1zxeyXD9Iw7MahcuE
	 DEKX+RuGxUphEj032kVb37umnFU4HpvHo8JjJyG90iZFbn8qy8zLH8ujJd8QZX0JyT
	 O9cg0ifRBIkmsNcXbPlXUBe3gbHs1yYd0FuTOgGZjMBJX/L93DLGVHADCRkCbkXYkr
	 jE5koynpgWAsgWxjBnhx3/k0/jibRZtFlwaCAXJvuiYu7CK8+OQmanqPmVk09KkXnD
	 RgMj1kF4Z+TNHUj8F4tp5MJKNXrjlubUbkmZ0faVv/3QFXQLa/1c8gjMoJPe/guSVS
	 p3tBzOOF76meg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6BEF4064C;
	Fri, 20 Nov 2026 18:54:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D0423169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDCDA60609
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B4TRaVwAOAeX for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 18:54:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A689605F9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8890=jk=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=DL+HtZT2; 
 dkim=pass (1024-bit key,
 unprotected) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=fTtenRxh
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A689605F9
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=fe-e1b5cab7be;
 t=1795200871; bh=CSyXkpmQpJrSqWHuGSZHoSrr0SU0hwP0p8VHtIBUO78=;
 b=DL+HtZT2K7Pnh7EyN29cI9Qk1IHaDYTf3obJ0GJU6QZ++BsOkgsh9MgvJsLUV1MLPwMfQL7r6
 99Ig4z+wGHcNq0FbtNEdb9zh8LtgmReuBDgzInnK1xxjLj5CkRlDEno7q8xUByIk6FwL09gLRt2
 4oXijMbQRPLsyYDLC1lsBoMXMn2TX+EOXrk0CNNn40JAv6iotBqEealUSPMkyx3o6YE3IeHdcSU
 DfkOCIz4LIKBM5G67yC26VUDgjL4vytJrmQP3GIDYWFDyrr0ae6MggaTGfaOy+h6ffK8oidv0BL
 mMnTgcssRVVGp2abTmmJwy3m4OcdkwIu6pFQxDWSWyUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=default;
 t=1795200871; bh=CSyXkpmQpJrSqWHuGSZHoSrr0SU0hwP0p8VHtIBUO78=;
 b=fTtenRxhlfuX+htU0r8/UCRzR7ZLfo3jMISPKAbKUB0KAtiL55EhndGhjU+aXn/EFIacn0Epx
 u7g29m88gdRGtEJPddx3FLF9lb+zKCyzhzENLsgXfVAw/5neTyUE5vvbmIC2yYqoWgLcsdNYWqS
 bAWRrs664UMdkyXXUMQDaCo=
CFBL-Feedback-ID: 6b009763af551cf52062463c:8ed1a0de79c6199f5a6e05cadad56ee8
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b009763af551cf52062463c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.33
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f050bec2-ca93-4ffc-97a0-2e840638920c@kwiboo.se>
Date: Fri, 20 Nov 2026 19:54:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RK3572 / OK3572-C support on top of your rk3562 branch
To: Quentin Schulz <quentin.schulz@cherry.de>, Cunhao Lu <1579567540@qq.com>
Cc: u-boot <u-boot@lists.u-boot-project.org>
References: <tencent_907535C1D3F4C91824948CA407902292FA0A@qq.com>
 <eb5ff808-d165-44f4-8620-48d68028ff71@kwiboo.se>
 <77ff29fb-545e-4e28-be30-2a0e6c2fdff2@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <77ff29fb-545e-4e28-be30-2a0e6c2fdff2@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin, Cunhao,

On 11/20/2026 5:43 PM, Quentin Schulz wrote:
> Hi Jonas, Cunhao,
> 
> On 10/22/26 9:16 PM, Jonas Karlman wrote:
>> Hi Cunhao,
>>
>> On 10/19/2026 9:49 AM, Cunhao Lu wrote:
>>> Hi Jonas,
>>>
>>> I've been working on U-Boot support for the Forlinx OK3572-C board, which
>>> uses the FET3572-C module. After finding your RK3572 support, I rebased my
>>> work onto your rk3562 branch and now use your SoC, clock, pinctrl and RAM
>>> drivers.
>>>
>>> I have three follow-up patches:
>>>
>>> - Add optional RBOOT + DDR + SPL three-stage image support to mkimage.
>>> - Add optional RBOOT firmware support to binman.
>>> - Add the OK3572-C device tree, defconfig and build documentation.
>>>    (With Forlinx OK3572-C BSP Alpha1)
>>>
>>> I have verified the complete boot flow from eMMC on the OK3572-C. The
>>> bootloader, kernel and root filesystem are all stored on eMMC, and the
>>> board boots into a minimal Debian 13 system.
>>>
>>> Do you have a submission plan for the RK3572 support in your branch?
>>> Would you prefer me to send these changes as a separate RFC series based
>>> on your branch, or coordinate them with your SoC support series?
>>
>> For Rockchip platform we typically require device tree for new SoCs and
>> boards to be picked from upstream Linux (the devicetree-rebasing tree).
>>
>> So the first step is usually to upstream dt-bindings, device tree and
>> core drivers to Linux before patches for the SoC are submitted to U-Boot.
>>
> 
> Just to be clear, the limitation only applies to dt-bindings and the 
> various Device Trees, but not to drivers. You're free to submit driver 
> support for new SoC whenever you feel like it. Of course, without a 
> dt-bindings agreed with upstream, the driver may not be compatible with 
> the dt-bindings once finalized, hence why it's a good idea to wait at 
> least for the dt-bindings for the driver to be merged in the Linux 
> kernel before sending patches for it in U-Boot. I think it's a 
> technicality since they (driver and its binding) are usually contributed 
> together in a single series, but you could do that, that's fine on my side.
> 
>> My rk3562 branch contains a long queue of new RK SoC support, some are
>> waiting on Linux upstream support, others are waiting on open U-Boot RK
>> refactoring series and/or other mailing list discussions. eMMC/SD-card,
>> Ethernet, RNG, OTP, SARADC and USB2 should be fully working for all the
>> pending SoCs in the rk3562 branch. All (or most) patches in rk3562
>> should eventually hit the mailing list, at least that's the goal.
>>
> 
> I think I've caught up with all your patches? Three series awaiting a 
> new version (or feedback) as far as I could tell:
> - https://lore.kernel.org/u-boot/20260805174509.2968252-1-jonas@kwiboo.se/
> - https://lore.kernel.org/u-boot/20260804214442.2592597-1-jonas@kwiboo.se/
> - https://lore.kernel.org/u-boot/20260804105721.2402406-1-jonas@kwiboo.se/
> 
> Is there something I missed that I should be doing? Let me know if I 
> somehow skipped a series or if I need to act on something.

Not that I know of, will continue and refresh series now that clock fixes
have landed, thanks!

Currently have following series in mind for a refresh and posting:
- misc fixes/improvements for rk3506 support
- cleanup: remove unneeded syscon driver for rk35xx
- cleanup: remove uses of rockchip_get_cru() helper
- refactor rk3506 clock driver (baseline for rk35xx clock drivers)

And then continue with following:
- add support for rk3562, rv1126b, rv1106, rv1103b
  - held back pending: cleanups and clock driver baseline
- add support for rk3538 and rk3572
  - held back pending: upstream dt-bindings
- continued clock driver cleanup/refactor for existing socs
- consistent tpl handling

> @Cunhao, the typical policy we have is that the first who contributes a 
> patch usually gets to work on it until it's satisfactory and can be 
> merged. We also typically do not care about unofficial trees, however 
> close they are to upstream: if you have patches, and you feel they are 
> good enough, you can send them even if another contributor has their own 
> patch for the same thing in their tree (and haven't sent patches yet). 
> Of course, do not go to a contributor tree and get patches from there 
> without having permission to do so. Please do not use LLMs "to be the 
> first" (or at all, we don't really like those here).

Personally I typically have no issue with others picking non-WIP marked
patches from my tree to possible help speed things along, at least not
after a quick ping. I have several Linux patches that landed upstream
that where submitted by others :-)

> I know Jonas has many many many patches in his tree and he's been a 
> relentless contributor and reviewer for anything Rockchip in U-Boot (and 
> I know he's very active in other communities as well), I'm very grateful 
> for that. I'm pretty sure Jonas was careful not to send too many patches 
> and overload me, so that is also very much appreciated.

Correct, I have tried not to keep too many series alive at the same time and
switched focus to fixes when issues with existing code was discovered.

> I'd like to both avoid duplicated work (Jonas and someone else doing the 
> same work) and also putting too much pressure on Jonas by contributors 
> "having to wait" for patches to land on the mailing list to start/resume 
> bring up of SoCs. "Putting all eggs in the same basket" kind of issues :)

I mostly just want to have consistent code and features for any new and
existing SoCs (focusing on newer RK35xx SoCs). To avoid spending too
much future time on possible cleanups of inconsistent code, I just
completed similar steps that I had already done to help bring up prior
RK35xx SoCs.

Patches still not being posted is in part due to trying to prioritize
what I though was going to be quick cleanups and fixes ahead of adding
any new SoC support, and also getting consensus on clock driver handling
using patches to refactor an existing SoC (rk3506) instead of tying to
sneak in inconsistent clock handling code using a new SoC.

I will try to reduce my pending queue by posting a few updated and new
series this weekend.

Regards,
Jonas

> No promise on when I can look at patches, I'm the sole custodian at the 
> moment and there's some decent backlog already :) That shouldn't prevent 
> you from sending patches to the mailing list and/or reviewing other 
> people's patches to help out, it's just that things will take time to 
> eventually get merged.
> 
> Cheers,
> Quentin

